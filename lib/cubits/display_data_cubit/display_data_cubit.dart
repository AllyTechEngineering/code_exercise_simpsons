import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_exercise_simpsons/repositories/code_exercise_repository.dart';
import 'package:code_exercise_simpsons/cubits/display_data_cubit/display_data_state.dart';

class DisplayDataCubit extends Cubit<DisplayDataState> {
  DisplayDataCubit({required this.repository}) : super(InitialState()) {
    getData();
  }

  final CodeExerciseRepository repository;

  void getData() async {
    try {
      emit(LoadingState());
      final movies = await repository.getCodeExData();
      print('$movies');
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
