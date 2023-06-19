import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:meta/meta.dart';

import '../../../../models/repositories/events_repository.dart';

part 'get_events_state.dart';

class GetEventsCubit extends Cubit<GetEventsState> {
  GetEventsCubit() : super(GetEventsInitial());

  StreamSubscription<List<EventModel>>? subscription;
  EventsRepository eventRepository = EventsRepository();

  Future<void> getEvents(code) async {
    try {
      emit(GetEventsLoading());
      if (subscription != null) {
        subscription!.cancel();
      }
      subscription = eventRepository.getEvents(code).listen((event) {
        emit(GetEventsLoaded(events: event));
      });
    } catch (e) {
      emit(GetEventsError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

}
