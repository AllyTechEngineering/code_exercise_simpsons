import 'package:code_exercise_simpsons/cubits/display_data_cubit/display_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/display_data_cubit/display_data_cubit.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.indexValue});
  final int indexValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Container(
        child: Column(
          children: [
            BlocBuilder<DisplayDataCubit, DisplayDataState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  final codeExerciseData = state.codeExerciseData;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(
                        'https://duckduckgo.com/${codeExerciseData[indexValue].url}',
                        fit: BoxFit.cover,
                      ),
                      title: Text(codeExerciseData[indexValue].text),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
