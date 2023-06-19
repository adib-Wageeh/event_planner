part of 'get_events_cubit.dart';

@immutable
abstract class GetEventsState {}

class GetEventsInitial extends GetEventsState {}

class GetEventsLoading extends GetEventsState {}

class GetEventsLoaded extends GetEventsState {
  final List<EventModel> events;
  GetEventsLoaded({required this.events});
}

class GetEventsError extends GetEventsState {
  final String error;
  GetEventsError({required this.error});
}
