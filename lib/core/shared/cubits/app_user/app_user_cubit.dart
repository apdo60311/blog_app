import 'package:bloc/bloc.dart';
import 'package:blog_app/core/shared/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'app_user_state.dart';

/// Manages user's current state whether logged in or not
///
/// The **AppUserCubit** is responsible for updating the state of the app user,which can be:
/// 1. [`AppUserInitial`] (when the user is not logged in)
/// 2. [`AppUserIsLoggedIn`] (when the user is logged in).
///
/// The [`updateUserState`] method is used to update the user state based on the
/// provided **[User]** object. If the **[User]** object is `null`, the state is set to [`AppUserInitial`].
///  Otherwise, the state is set to [`AppUserIsLoggedIn`] with the provided [**User**] object.
class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUserState(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserIsLoggedIn(user: user));
    }
  }
}
