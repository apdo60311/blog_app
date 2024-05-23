import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/shared/entities/user.dart';
import 'package:blog_app/features/Authentication/domain/usecases/current_user.dart';
import 'package:blog_app/features/Authentication/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/Authentication/domain/usecases/user_sign_up.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserSignUp _userSignUpUsecase;
  final UserSignIn _userSignInUsecase;
  final CurrentUser _currentUserUsecase;

  final AppUserCubit _appUserCubit;

  AuthenticationBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUpUsecase = userSignUp,
        _userSignInUsecase = userSignIn,
        _currentUserUsecase = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>(_onLoading);
    on<AuthenticationSignup>(_onSignup);
    on<AuthenticationSignin>(_onSignin);
    on<AuthenticationCheck>(_onAuthCheck);
  }

  FutureOr<void> _onLoading(event, emit) => emit(AuthenticationLoadingState());

  FutureOr<void> _onSignup(
      AuthenticationSignup event, Emitter<AuthenticationState> emit) async {
    final response = await _userSignUpUsecase(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));

    response.fold(
      (failure) => emit(AuthenticationFailureState(message: failure.message)),
      (user) => _emitAuthSuccessAndUpdateAppUserState(user, emit),
    );
  }

  FutureOr<void> _onSignin(
      AuthenticationSignin event, Emitter<AuthenticationState> emit) async {
    final response = await _userSignInUsecase(
        UserSignInParams(email: event.email, password: event.password));

    response.fold(
      (failure) => emit(AuthenticationFailureState(message: failure.message)),
      (user) => _emitAuthSuccessAndUpdateAppUserState(user, emit),
    );
  }

  FutureOr<void> _onAuthCheck(
      AuthenticationCheck event, Emitter<AuthenticationState> emit) async {
    final response = await _currentUserUsecase(NoParams());
    response.fold(
      (failure) => emit(AuthenticationFailureState(message: failure.message)),
      (user) => _emitAuthSuccessAndUpdateAppUserState(user, emit),
    );
  }

  void _emitAuthSuccessAndUpdateAppUserState(
      User user, Emitter<AuthenticationState> emitter) {
    emitter(AuthenticationSuccessState(user: user));
    _appUserCubit.updateUserState(user);
  }
}
