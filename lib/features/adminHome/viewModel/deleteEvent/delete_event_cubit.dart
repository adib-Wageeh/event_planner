import 'package:bloc/bloc.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:event_planner/models/repositories/events_repository.dart';
import 'package:meta/meta.dart';

part 'delete_event_state.dart';

class DeleteEventCubit extends Cubit<DeleteEventState> {
  DeleteEventCubit() : super(DeleteEventInitial());

  EventsRepository eventsRepository = EventsRepository();

  Future<void> deleteEvent(EventModel eventModel,String codeId)async{

    emit(DeleteEventLoading());
    await eventsRepository.deleteEvent(eventModel, codeId);
    emit(DeleteEventDone());
  }

}
