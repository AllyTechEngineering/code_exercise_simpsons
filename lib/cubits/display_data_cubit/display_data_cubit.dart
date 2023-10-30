import 'dart:async';
import 'package:code_exercise_simpsons/cubits/search_data_cubit/search_data_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_exercise_simpsons/repositories/code_exercise_repository.dart';
import 'package:code_exercise_simpsons/cubits/display_data_cubit/display_data_state.dart';

import '../../models/code_exercise_model.dart';

class DisplayDataCubit extends Cubit<DisplayDataState> {
  late final StreamSubscription searchCubitSubscription;
  final SearchDataCubit searchDataCubit;
  final CodeExerciseRepository repository;

  DisplayDataCubit({required this.repository, required this.searchDataCubit})
      : super(InitialState()) {
    searchCubitSubscription = searchDataCubit.stream.listen((SearchDataState searchDataState) {
      getData();
    });
    getData();
  }

  void getData() async {
    List<CodeExerciseModel> _filteredList;
    try {
      emit(LoadingState());
      final dataList = await repository.getCodeExData();
      if (searchDataCubit.state.searchTerm.isNotEmpty) {
        print('Inside of search if statement - search term: ${searchDataCubit.state.searchTerm}');
        _filteredList = dataList
            .where((CodeExerciseModel codeExerciseModel) =>
                codeExerciseModel.text.toLowerCase().contains(searchDataCubit.state.searchTerm))
            .toList();
        emit(LoadedState(_filteredList));
      } else if (searchDataCubit.state.searchTerm.isEmpty) {
        print(
            'Inside of else if statement - search term is empty: ${searchDataCubit.state.searchTerm}');
        emit(LoadedState(dataList));
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
