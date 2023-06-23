part of 'attend_cubit.dart';

@immutable
abstract class AttendState {}

class AttendInitial extends AttendState {}

class IsAttendant extends AttendState {}

class NotAttendant extends AttendState {}
