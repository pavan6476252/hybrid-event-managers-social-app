import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hybrid/core/api_resository.dart';
import 'package:hybrid/features/posts/domain/model/post_model.dart';
import '../../../../../core/failure.dart';

part 'current_user_posts_event.dart';
part 'current_user_posts_state.dart';

class CurrentUserPostsBloc
    extends Bloc<CurrentUserPostsEvent, CurrentUserPostsState> {
  ApiRepository apiRepository;
  CurrentUserPostsBloc(this.apiRepository) : super(CurrentUserPostsInitial()) {
    on<CurrentUserPostsGetEvent>(_getPosts);
    on<CurrentUserPostsGetNextEvent>(_getNextPosts);
  }

  _getPosts(event, emit) async {

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final res = await apiRepository.get('http://localhost:3000/api/posts/',
        requireAuth: true, token: token );

    res.fold(
      (failure) {
        emit(CurrentUserPostsFailed(failure: failure));
      },
      (response) {
        if (event is CurrentUserPostsGetNextEvent) {
          // Handle CurrentUserPostsGetNextEvent
          emit(CurrentUserPostsLoaded([
            ...(((response.data) as Map<String, dynamic>)['data']
                    as List<dynamic>)
                .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
                .toList(),
            ...event.posts
          ]));
        } else {
          // Handle FeedPostsGetEvent
          emit(CurrentUserPostsLoaded(
            (((response.data) as Map<String, dynamic>)['data'] as List<dynamic>)
                .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          ));
        }
      },
    );
  }

  _getNextPosts(CurrentUserPostsGetNextEvent event, emit) async {

    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final res = await apiRepository.get(
      'http://localhost:3000/api/posts/',
      requireAuth: true,
      token: token ,
      queryParameters: {"page": event.page.toString()},
    );
    res.fold(
      (failure) {
        print(failure.message);
        print(failure.stackTrace);
        emit(CurrentUserPostsFailed(failure: failure));
      },
      (response) {
        // print(response.body);
        final posts =
            (((response.data) as Map<String, dynamic>)['data'] as List<dynamic>)
                .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
                .toList();

        emit(CurrentUserPostsLoaded([...event.posts, ...posts]));
      },
    );
  }
}
