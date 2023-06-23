part of 'delete_event_cubit.dart';

@immutable
abstract class DeleteEventState {}

class DeleteEventInitial extends DeleteEventState {}

class DeleteEventLoading extends DeleteEventState {}

class DeleteEventDone extends DeleteEventState {}

