import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:hybrid/core/api_resository.dart';
import 'package:hybrid/core/failure.dart';
import 'package:hybrid/features/posts/domain/model/post_model.dart';

part 'post_creating_event.dart';
part 'post_creating_state.dart';

class PostCreatingBloc extends Bloc<PostCreatingEvent, PostCreatingState> {
  ApiRepository apiRepository;
  PostCreatingBloc(this.apiRepository) : super(PostCreatingInitial()) {
    on<PostThePostEvent>(_postThePost);
  }
  _postThePost(event, emit) async {
    emit(PostCreatingLoading());
    List<String> items = [];
    for (var item in event.items) {
      items.add(item.toJson());
    }
    FormData formData = FormData.fromMap({
      'description': event.description,
      'items': items.toString(),
      'isBuySell': event.isBuySell,
      'images': [
        for (var file in event.images)
          MultipartFile.fromFileSync(
            file.path,
            filename: file.path.split('/').last,
          )
      ],
      'otherData': 'some other data',
    });
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final response = await apiRepository
        .post("http://localhost:3000/api/posts", formData, token: token ?? "");

    response.fold((failure) {
      log(failure.stackTrace.toString());
      log(failure.message);
      emit(PostCreatingFailed(failure));
    }, (response) {
      emit(PostCreatingSuccess(response.data.toString()));
    });
  }
}
