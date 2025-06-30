import 'dart:math';

import 'package:app/domain/entities/cat.dart';
import 'package:app/domain/filter.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:app/presentation/details/screen.dart';
import 'package:app/presentation/util/netimage.dart';
import 'package:app/presentation/util/swipable.dart';
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

  Future<DateTime> _fetchLikeDate() async {
    return GetIt.I.get<HistoryRepository>().getLikeDate(cat);
  }

  Future<void> _removeLike() async {
    return GetIt.I.get<HistoryRepository>().removeLike(cat);
  }

  double _calcImageSize(context) {
    return min(
      MediaQuery.of(context).size.width * 1.3,
      MediaQuery.of(context).size.height - 300,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (ctx, _) => Material(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Swipable(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Card(
                child: Column(
                  children: [
                    NetImage(
                      url: cat.imageUrl,
                      height: _calcImageSize(context),
                    ),
                    TextBox(text: cat.breed),
                    FutureBuilder<DateTime>(
                      future: _fetchLikeDate(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final likeDate = snapshot.data!;
                          return FooterTextBox(
                            text: DateFormat("hh:mm dd.MM").format(likeDate),
                          );
                        }
                        return FooterTextBox(text: "");
                      },
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    AppScreen(screen: DetailsScreen(cat: (() async => cat)())),
              ),
            ),
            onLeftSwipe: () => _removeLike(),
            onRightSwipe: () => _removeLike(),
          ),
        ),
      ),
    );
  }
}
