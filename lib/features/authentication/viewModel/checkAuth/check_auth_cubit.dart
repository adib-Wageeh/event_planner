import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:device_information/device_information.dart';
import 'package:event_planner/models/code_model/user_model.dart';
import 'package:event_planner/models/repositories/messaging_repository.dart';
import 'package:event_planner/models/repositories/permissions_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/repositories/codes_repository.dart';
part 'check_auth_state.dart';

class CheckAuthCubit extends Cubit<CheckAuthState> {
  CheckAuthCubit() : super(CheckAuthInitial());

  CodesRepository codesRepository = CodesRepository();
  MessagingRepository messagingRepository = MessagingRepository();
  PermissionRepository permissionRepository = PermissionRepository();
  StreamSubscription<Either<bool, UserModel>>? _subscription;

  void checkAuth() async {
    emit(CheckAuthLoading());

    TargetPlatform platform;

    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }

    PermissionName permissionsState = await permissionRepository.checkPermission(platform);

    if(permissionsState == PermissionName.none) {
      final imeiNo = await DeviceInformation.deviceIMEINumber;
      _subscription =
          codesRepository.checkAuthenticated(imeiNo).listen((event) {
            event.fold((l) {
              if (l == true) {
                emit(CheckAuthBlocked());
              } else {
                emit(CheckAuthUnAuthenticated());
              }
            }, (r) {
              emit(CheckAuthAuthenticated(userModel: r));
            });
          });
    }else{
      if(permissionsState == PermissionName.phone)
      {
        emit(CheckAuthPermissionRejected(permission: "phone"));
      }else if(permissionsState == PermissionName.storage){
        emit(CheckAuthPermissionRejected(permission: "storage"));
      }else{
        emit(CheckAuthPermissionRejected(permission: "notification"));
      }
    }

  }

}
