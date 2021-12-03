import 'package:core/presentation/bloc/serial/popular_serials/popular_serials_bloc.dart';
import 'package:core/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularSerialsPage extends StatefulWidget {
  const PopularSerialsPage({Key? key}) : super(key: key);

  @override
  _PopularSerialsPageState createState() => _PopularSerialsPageState();
}

class _PopularSerialsPageState extends State<PopularSerialsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularSerialsBloc>().add(const FetchPopularSerials()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Serials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSerialsBloc, PopularSerialsState>(
          builder: (context, state) {
            if (state is PopularSerialsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSerialsHasData) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final serial = result[index];
                  return SerialCard(serial);
                },
                itemCount: result.length,
              );
            } else if (state is PopularSerialsError) {
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
