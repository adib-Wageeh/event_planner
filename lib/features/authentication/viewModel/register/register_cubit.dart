import 'package:bloc/bloc.dart';
import 'package:event_planner/models/code_model/code_model.dart';
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
    final res = await registerRepository.register(code.text, username.text);
    res.fold((l) {
      if(l == false){
        emit(RegisterError(error: "code not found"));
      }
    }, (r) {
    });

  }

}
