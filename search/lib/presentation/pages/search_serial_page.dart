import 'package:core/core.dart';
import 'package:core/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_serials_bloc.dart';

class SearchSerialPage extends StatelessWidget {
  const SearchSerialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchSerialsBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchSerialsBloc, SearchSerialsState>(
              builder: (context, state) {
                if (state is SearchSerialsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchSerialsHasData) {
                  final result = state.result;

                  if (result.isEmpty) {
                    return const Center(child: Text('No Serial added'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return SerialCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchSerialsError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
