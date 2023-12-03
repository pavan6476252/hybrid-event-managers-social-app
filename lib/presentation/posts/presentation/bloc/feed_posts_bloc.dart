import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hybrid/core/api_resository.dart';
import 'package:hybrid/core/core.dart';
import 'package:http/http.dart';
import 'package:hybrid/presentation/posts/domain/model/post_model.dart';
part 'feed_posts_event.dart';
part 'feed_posts_state.dart';

class FeedPostsBloc extends Bloc<FeedPostsEvent, FeedPostsState> {
  ApiRepository apiRepository;

  FeedPostsBloc(this.apiRepository) : super(FeedPostsInitial()) {
    on<FeedPostsGetEvent>(_getPosts);
    on<FeedPostsGetNextEvent>(_getNextPosts);
  }

_getPosts(event, emit) async {
  final res = await apiRepository.get('http://localhost:3000/api/posts/', requireAuth: false);
  res.fold(
    (failure) {
      emit(FeedPostsFailed(failure: failure));
    },
    (response) {
      if (event is FeedPostsGetNextEvent) {
        // Handle FeedPostsGetNextEvent
        emit(FeedPostsLoaded([
          ...((jsonDecode(response.body) as Map<String, dynamic>)['data'] as List<dynamic>)
              .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          ...event.posts
        ]));
      } else {
        // Handle FeedPostsGetEvent
        emit(FeedPostsLoaded(
          ((jsonDecode(response.body) as Map<String, dynamic>)['data'] as List<dynamic>)
              .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        ));
      }
    },
  );
}
_getNextPosts(FeedPostsGetNextEvent event, emit) async {
  final res = await apiRepository.get(
    'http://localhost:3000/api/posts/',
    requireAuth: false,
    queryParameters: {"page": event.page.toString()},
  );
  res.fold(
    (failure) {
      emit(FeedPostsFailed(failure: failure));
    },
    (response) {
      // print(response.body);
      final posts = ((jsonDecode(response.body) as Map<String, dynamic>)['data'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(FeedPostsLoaded([...event.posts, ...posts]));
    },
  );
}

}