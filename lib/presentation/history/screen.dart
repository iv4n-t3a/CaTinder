import 'package:app/domain/filter.dart';
import 'package:app/presentation/history/filter.dart';
import 'package:app/presentation/history/item.dart';
import 'package:app/presentation/util/button.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _filterShown = false;

  void _switchFilterView() {
    setState(() => _filterShown = !_filterShown);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: "History"),
        centerTitle: true,
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (ctx, state) {
          return Stack(
            children: [
              FutureBuilder<List<HistoryItem>>(
                  future: ctx
                      .read<FilterCubit>()
                      .filteredItems
                      .map((cat) => HistoryItem(cat: cat))
                      .toList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final likes = snapshot.data!;
                      return ListView(children: likes);
                    }
                    return const SizedBox.shrink();
                  }),
              if (_filterShown) Filter(close: _switchFilterView)
            ],
          );
        },
      ),
      floatingActionButton: !_filterShown
          ? Button(
              onPressed: _switchFilterView,
              icon: Icons.menu,
            )
          : null,
    );
  }
}
