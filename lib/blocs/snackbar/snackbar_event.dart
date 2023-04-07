part of 'snackbar_bloc.dart';

abstract class SnackBarEvent {}

class ShowSnackBarEvent extends SnackBarEvent {
  String title;
  String content;
  ShowSnackBarEvent({required this.title, required this.content});
}
