import 'package:app/domain/filter.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:app/presentation/util/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Filter extends StatefulWidget {
  final Function close;

  const Filter({
    super.key,
    required this.close,
  });

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Card(
          child: BlocBuilder<FilterCubit, FilterState>(
            builder: (ctx, state) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView(
                    children: List.from(
                      ctx.read<FilterCubit>().filterMap.entries.map(
                            (entry) => CheckboxListTile(
                              value: entry.value,
                              onChanged: (bool? value) {
                                ctx
                                    .read<FilterCubit>()
                                    .setBreed(entry.key, value!);
                              },
                              title: TextBox(text: entry.key),
                            ),
                          ),
                    ),
                  ),
                ),
                CaTinderTextButton(
                  text: 'OK',
                  onPressed: () => widget.close(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
