import 'package:flutter_bloc/flutter_bloc.dart';

part 'snackbar_state.dart';
part 'snackbar_event.dart';

class SnackBarBloc extends Bloc<SnackBarEvent, SnackBarState> {
  SnackBarBloc()
      : super(SnackBarState(
          title: "",
          content: "",
        )) {
    on<ShowSnackBarEvent>(
      (event, emit) {
        emit(SnackBarState(
          title: event.title,
          content: event.content,
        ));
      },
    );
  }
}
