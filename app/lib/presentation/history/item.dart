import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/filter.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:app/presentation/details/screen.dart';
import 'package:app/presentation/util/netimage.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:app/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  final Cat cat;

  const HistoryItem({
    super.key,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: BlocBuilder<FilterCubit, FilterState>(
            builder: (ctx, state) => CloseButton(
              onPressed: () => ctx.read<FilterCubit>().removeLike(cat),
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                child: Card(
                  child: Column(
                    children: [
                      NetImage(url: cat.imageUrl),
                      TextBox(text: cat.breed),
                      FooterTextBox(
                          text: DateFormat("hh:mm dd.MM").format(GetIt.I
                              .get<HistoryRepository>()
                              .getLikeDate(cat))),
                    ],
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AppScreen(
                        screen: DetailsScreen(cat: (() async => cat)())),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
