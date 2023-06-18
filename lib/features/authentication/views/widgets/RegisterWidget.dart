import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../viewModel/register/register_cubit.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },child: Center(
      child: Container(
        padding: const EdgeInsets.all(22),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black54,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: context.read<RegisterCubit>().username,
              style: const TextStyle(color: Colors.black), // set the text color to black
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: context.read<RegisterCubit>().code,
              style: const TextStyle(color: Colors.black), // set the text color to black
              decoration: InputDecoration(
                hintText: 'Code',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 12),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                if(state is RegisterLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return ElevatedButton(onPressed: () {
                  context.read<RegisterCubit>().register();
                },
                  style: ElevatedButton.styleFrom(backgroundColor: kAppAccentColor), child: const Text('Register'),
                );
              },
            ),
          ],
        ),
      ),
    )
    );
  }
}