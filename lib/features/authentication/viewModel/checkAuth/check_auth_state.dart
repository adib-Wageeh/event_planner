part of 'check_auth_cubit.dart';

@immutable
abstract class CheckAuthState {}

class CheckAuthInitial extends CheckAuthState {}

class CheckAuthLoading extends CheckAuthState {}

class CheckAuthAuthenticated extends CheckAuthState {
  final UserModel userModel;
  CheckAuthAuthenticated({required this.userModel});
}

class CheckAuthUnAuthenticated extends CheckAuthState {}

class CheckAuthBlocked extends CheckAuthState {}

class CheckPermissionAccepted extends CheckAuthState {}

class CheckAuthPermissionRejected extends CheckAuthState {
  final String permission;
  CheckAuthPermissionRejected({required this.permission});
}
