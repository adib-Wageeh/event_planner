import 'package:bloc/bloc.dart';

import '../../../../models/code_model/user_model.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  void setUser(UserModel user) => emit(user);

  void clearUser() => emit(null);
}