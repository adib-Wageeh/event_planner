import 'package:device_info_plus/device_info_plus.dart';
import 'package:event_planner/features/adminHome/viewModel/addEvent/add_event_cubit.dart';
import 'package:event_planner/features/adminHome/viewModel/deleteEvent/delete_event_cubit.dart';
import 'package:event_planner/features/adminHome/viewModel/downloadFile/download_file_cubit.dart';
import 'package:event_planner/features/adminHome/viewModel/getEvents/get_events_cubit.dart';
import 'package:event_planner/features/userHome/viewModel/Attend/attend_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'features/authentication/viewModel/checkAuth/check_auth_cubit.dart';
import 'features/authentication/viewModel/connectivity/connectivity_cubit.dart';
import 'features/authentication/viewModel/current_user/current_user_cubit.dart';
import 'features/authentication/viewModel/register/register_cubit.dart';
import 'features/authentication/views/loginView.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final deviceInfo = await DeviceInfoPlugin().androidInfo;

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context)=> ConnectivityCubit()..initConnectivity()),
    BlocProvider(create: (context)=> CheckAuthCubit()..checkAuth()),
    BlocProvider(create: (context)=> RegisterCubit()),
    BlocProvider(create: (context)=> UserCubit()),
    BlocProvider(create: (context)=> GetEventsCubit()),
    BlocProvider(create: (context)=> AddEventCubit()),
    BlocProvider(create: (context)=> DownloadFileCubit()),
    BlocProvider(create: (context)=> AttendCubit()),
    BlocProvider(create: (context)=> DeleteEventCubit()),
  ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: kAppPrimaryColor,
            colorScheme: ColorScheme.dark(
              secondary: kAppAccentColor,
            ),
          ),
          home: const LoginView())));
}
