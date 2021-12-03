import 'package:core/presentation/bloc/serial/top_rated_serials/top_rated_serials_bloc.dart';
import 'package:core/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedSerialsPage extends StatefulWidget {
  const TopRatedSerialsPage({Key? key}) : super(key: key);

  @override
  _TopRatedSerialsPageState createState() => _TopRatedSerialsPageState();
}

class _TopRatedSerialsPageState extends State<TopRatedSerialsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<TopRatedSerialsBloc>().add(const FetchTopRatedSerials()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Serials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSerialsBloc, TopRatedSerialsState>(
          builder: (context, state) {
            if (state is TopRatedSerialsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSerialsHasData) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final serial = result[index];
                  return SerialCard(serial);
                },
                itemCount: result.length,
              );
            } else if (state is TopRatedSerialsError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
