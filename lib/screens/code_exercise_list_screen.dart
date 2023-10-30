import 'package:code_exercise_simpsons/models/code_exercise_model.dart';
import 'package:code_exercise_simpsons/screens/detail_screen.dart';
import 'package:code_exercise_simpsons/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_exercise_simpsons/cubits/display_data_cubit/display_data_cubit.dart';
import 'package:code_exercise_simpsons/cubits/display_data_cubit/display_data_state.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class CodeExerciseListScreen extends StatefulWidget {
  @override
  _CodeExerciseListScreenState createState() => _CodeExerciseListScreenState();
}

class _CodeExerciseListScreenState extends State<CodeExerciseListScreen> {
  int indexValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Exercise'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SearchScreen(),
              BlocBuilder<DisplayDataCubit, DisplayDataState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ErrorState) {
                    return Center(
                      child: Icon(Icons.close),
                    );
                  } else if (state is LoadedState) {
                    final codeExerciseData = state.codeExerciseData;
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: codeExerciseData.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(codeExerciseData[index]
                                .text
                                .split('-')
                                .first), //only shows he name. Removes the details of the description after the ' - ' char.
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    indexValue: index,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
      ),
    );
  }

  CircleAvatar buildCircleAvatar(List<CodeExerciseModel> codeExerciseData, int index) {
    return CircleAvatar(
      backgroundImage:
          NetworkImage('${codeExerciseData[index].firstUrl}${codeExerciseData[index].url}'),
    );
  }
}
