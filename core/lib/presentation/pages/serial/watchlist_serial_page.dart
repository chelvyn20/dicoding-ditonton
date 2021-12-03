import 'package:core/common/utils.dart';
import 'package:core/presentation/bloc/serial/watchlist_serial/watchlist_serial_bloc.dart';
import 'package:core/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistSerialPage extends StatefulWidget {
  const WatchlistSerialPage({Key? key}) : super(key: key);

  @override
  _WatchlistSerialPageState createState() => _WatchlistSerialPageState();
}

class _WatchlistSerialPageState extends State<WatchlistSerialPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<WatchlistSerialBloc>().add(const FetchWatchlistSerial()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistSerialBloc>().add(const FetchWatchlistSerial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serial Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSerialBloc, WatchlistSerialState>(
          builder: (context, state) {
            if (state is WatchlistSerialLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSerialHasData) {
              final result = state.result;

              if (result.isEmpty) {
                return const Center(
                  key: Key('no_data'),
                  child: Text('No Serial added'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final serial = result[index];
                  return SerialCard(serial);
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistSerialError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
