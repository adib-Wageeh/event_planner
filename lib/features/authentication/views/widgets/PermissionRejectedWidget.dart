import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/checkAuth/check_auth_cubit.dart';

class PermissionRejectedWidget extends StatelessWidget {
  const PermissionRejectedWidget({Key? key}) : super(key: key);

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
            const Text(textAlign: TextAlign.center,"You can not use the app without accepting phone permission"),
            const SizedBox(height: 8,),
            const Text("Please enable phone permission in app settings"),
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