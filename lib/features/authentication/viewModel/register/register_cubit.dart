import 'package:bloc/bloc.dart';
import 'package:event_planner/models/repositories/register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  TextEditingController username= TextEditingController();
  TextEditingController code= TextEditingController();
  RegisterRepository registerRepository = RegisterRepository();

  Future<void> register()async{

    emit(RegisterLoading());
    if(username.text.isNotEmpty && code.text.isNotEmpty) {
      final res = await registerRepository.register(code.text, username.text);
      res.fold((l) {
        if (l == false) {
          emit(RegisterError(error: "code not found"));
        }else if(l == true){
          emit(RegisterError(error: "username already exists"));
        }
      }, (r) {});
    }else{
     if(username.text.isEmpty){
       emit(RegisterError(error: "please enter your username"));
     } else{
       emit(RegisterError(error: "please enter your code"));
     }
    }
  }


  void closeCubit() {
    username.clear();
    code.clear();
    emit(RegisterInitial());
  }

}
