import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:device_information/device_information.dart';
import 'package:event_planner/models/code_model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../models/repositories/codes_repository.dart';

part 'check_auth_state.dart';

class CheckAuthCubit extends Cubit<CheckAuthState> {
  CheckAuthCubit() : super(CheckAuthInitial());

  CodesRepository codesRepository = CodesRepository();
  StreamSubscription<Either<bool, UserModel>>? _subscription;

  void checkAuth()async{
    emit(CheckAuthLoading());
      final res = await requestPhoneStatePermission();
      if(res == 1){
        final imeiNo = await DeviceInformation.deviceIMEINumber;
        _subscription =
            codesRepository.checkAuthenticated(imeiNo).listen((event) async{
              final res = await requestPhoneStatePermission();
              if(res == 2){
                emit(CheckAuthPermissionRejected());
              }else if(res == 1){
              event.fold((l) {
                if (l == true) {
                  emit(CheckAuthBlocked());
                } else {
                  emit(CheckAuthUnAuthenticated());
                }
              }, (r) {
                emit(CheckAuthAuthenticated(userModel: r));
              });
            }else{
                emit(CheckAuthPermissionRejectedPermanently());
              }
            });
      }else if (res == 2){
        emit(CheckAuthPermissionRejected());
      }else{
        emit(CheckAuthPermissionRejectedPermanently());
      }

  }

  Future<int> requestPhoneStatePermission() async{
    emit(CheckAuthLoading());
    final res = await Permission.phone.isPermanentlyDenied;
    if(res){
      return 3;
    }else{
      final event = await Permission.phone.request();
      if (event.isGranted) {
        return 1;
      }else {
        return 2;
      }
    }
  }


}
