part of 'download_file_cubit.dart';

@immutable
abstract class DownloadFileState {}

class DownloadFileInitial extends DownloadFileState {}

class DownloadFileDownloading extends DownloadFileState {
  final List<FileData> fileData;
  DownloadFileDownloading({required this.fileData});

}

class DownloadFileDownloaded extends DownloadFileState {
  final FileData fileData;
  DownloadFileDownloaded({required this.fileData});
}

class DownloadFileDownloadError extends DownloadFileState {}
