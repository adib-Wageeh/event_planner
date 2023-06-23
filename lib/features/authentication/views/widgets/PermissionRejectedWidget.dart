import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/checkAuth/check_auth_cubit.dart';

class PermissionRejectedWidget extends StatelessWidget {
  final String permission;
  const PermissionRejectedWidget({required this.permission,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
            color: Colors.black54
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Text(textAlign: TextAlign.center,"You can not use the app without accepting $permission permission"),
            const SizedBox(height: 8,),
            Text("Please enable $permission permission in app settings",textAlign: TextAlign.center),
            const SizedBox(height: 8,),
            ElevatedButton(onPressed: (){
              context.read<CheckAuthCubit>().checkAuth();
            }, child: const Text("try Again"))
          ],
        ),
      ),
    );
  }
}