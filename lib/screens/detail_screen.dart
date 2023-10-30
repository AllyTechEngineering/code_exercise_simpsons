import 'package:cached_network_image/cached_network_image.dart';
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
        title: Text('Code Exercise Details'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              BlocBuilder<DisplayDataCubit, DisplayDataState>(
                builder: (context, state) {
                  if (state is LoadedState) {
                    final codeExerciseData = state.codeExerciseData;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: 'https://duckduckgo.com/${codeExerciseData[indexValue].url}',
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.no_photography,
                            color: Colors.white60,
                          ),
                        ),
                        subtitle: Text(codeExerciseData[indexValue].text),
                        title: Text(codeExerciseData[indexValue].text.split('-').first),
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
}
