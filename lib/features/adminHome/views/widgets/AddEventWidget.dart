import 'package:event_planner/features/authentication/viewModel/current_user/current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../viewModel/addEvent/add_event_cubit.dart';
import 'TextFieldWidget.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class AddEventWidget extends StatelessWidget {
  const AddEventWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWidget(
                focusNode: context.read<AddEventCubit>().focusNode,
                controller: context.read<AddEventCubit>().title,
                label: "Event title",
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  context.read<AddEventCubit>().focusNode.unfocus();
                  await getDateAndTime(context);
                },
                child: const Text('Select Date and Time'),
              ),
              BlocBuilder<AddEventCubit, AddEventState>(
                buildWhen: (previousState, state) {
                  return (state is AddEventDate);
                },
                builder: (context, state) {
                  if (state is AddEventDate) {
                    return Text(DateFormat('dd/MM/yyyy hh:mm a').format(state.dateTime));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(allowMultiple: true,);
                  if (result != null) {
                    context.read<AddEventCubit>().addFiles(result.files);
                  }
                },
                child: const Text('Select Files'),
              ),
              const ListOfFilesAddEventWidget(),
            ],
          ),
        ),
        actions: const [
          CancelButtonAddEventWidget(),
          AddButtonAddEventWidget(),
        ],
      );
  }

  Future<void> getDateAndTime(BuildContext context)async{

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    TimeOfDay? selectedTime;
    if(selectedDate != null){
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
    }
    if (selectedTime != null && selectedDate!= null) {
      // Combine date and time into a single DateTime object
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      context.read<AddEventCubit>().addDate(selectedDate);
    }
  }

}

class AddButtonAddEventWidget extends StatelessWidget {
  const AddButtonAddEventWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEventCubit, AddEventState>(
      listener: (context, state) {
        if (state is AddEventError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is AddEventDone) {
          context.read<AddEventCubit>().clearControllers();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is AddEventLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () async {
            String codeId = context.read<UserCubit>().state!.codeModel.id;
            await context.read<AddEventCubit>().addEvent(codeId);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kAppAccentColor,
          ),
          child: const Text("Add"),
        );
      },
    );
  }
}

class CancelButtonAddEventWidget extends StatelessWidget {
  const CancelButtonAddEventWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventState>(
      builder: (context, state) {
        if (state is AddEventLoading) {
          // If the current state is AddEventLoading, don't show the Cancel button
          return const SizedBox();
        } else {
          // Otherwise, show the Cancel button
          return TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AddEventCubit>().clearControllers();
            },
            child: const Text("Cancel"),
          );
        }
  },
);
  }
}

class ListOfFilesAddEventWidget extends StatelessWidget {
  const ListOfFilesAddEventWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventState>(
      buildWhen: (previousState, state) {
        return (state is AddEventFiles);
      },
      builder: (context, state) {
        if (state is AddEventFiles) {
          return Column(
            children: state.files.asMap().entries.map((entry) {
              final file = entry.value;
              return Row(
                children: [
                  Expanded(child: Text(file.name)),
                  IconButton(
                    onPressed: () {
                      context.read<AddEventCubit>().removeFileAt(entry.key);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }
}
