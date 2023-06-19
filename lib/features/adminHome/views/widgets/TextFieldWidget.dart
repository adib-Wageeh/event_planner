import 'package:event_planner/features/adminHome/viewModel/addEvent/add_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final FocusNode focusNode;
  final TextEditingController controller;
  const TextFieldWidget({required this.focusNode,required this.label,required this.controller,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
