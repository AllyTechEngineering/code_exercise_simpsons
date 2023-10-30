import 'package:code_exercise_simpsons/cubits/display_data_cubit/display_data_cubit.dart';
import 'package:code_exercise_simpsons/cubits/search_data_cubit/search_cubit.dart';
import 'package:code_exercise_simpsons/screens/code_exercise_list_screen.dart';
import 'package:code_exercise_simpsons/repositories/code_exercise_repository.dart';
import 'package:code_exercise_simpsons/utilities/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider<DisplayDataCubit>(
          create: (context) => DisplayDataCubit(
            repository: CodeExerciseRepository(
              Dio(),
            ),
          ),
          child: CodeExerciseListScreen(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: CodeExerciseListScreen(),
      ),
    );
  }
}

// BlocProvider<DisplayDataCubit>(
// create: (context) => DisplayDataCubit(
// repository: CodeExerciseRepository(
// Dio(),
// ),
// ),
// child: CodeExerciseListScreen(),
// ),
