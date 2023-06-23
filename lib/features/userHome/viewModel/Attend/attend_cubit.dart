import 'package:bloc/bloc.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:event_planner/models/repositories/events_repository.dart';
import 'package:meta/meta.dart';

part 'attend_state.dart';

class AttendCubit extends Cubit<AttendState> {
  AttendCubit() : super(AttendInitial());

  EventsRepository eventsRepository = EventsRepository();

  Stream<bool> isAttendant(String username, EventModel eventModel, String codeId) {
    return eventsRepository.isAttendant(username, eventModel, codeId);
  }


  Future<void> acceptEvent(String username,EventModel eventModel,String codeId)async{

    await eventsRepository.acceptEvent(username, eventModel, codeId);
  }

  Future<void> refuseEvent(String username,EventModel eventModel,String codeId)async{

    await eventsRepository.refuseEvent(username, eventModel, codeId);
  }
}
