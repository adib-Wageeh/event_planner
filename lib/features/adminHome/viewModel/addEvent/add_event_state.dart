part of 'add_event_cubit.dart';

@immutable
abstract class AddEventState {}

class AddEventInitial extends AddEventState {}

class AddEventLoading extends AddEventState {}

class AddEventDone extends AddEventState {

}

class AddEventDate extends AddEventState {
final DateTime dateTime;
AddEventDate({required this.dateTime});
}

class AddEventError extends AddEventState {
  final String error;
  AddEventError({required this.error});
}

class AddEventFiles extends AddEventState {
  final List<PlatformFile> files;
  AddEventFiles({required this.files});
}
