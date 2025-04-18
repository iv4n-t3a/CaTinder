import 'package:app/domain/repositories/history.dart';
import 'package:app/domain/swiper.dart';
import 'package:app/presentation/details/screen.dart';
import 'package:app/presentation/swiper/card.dart';
import 'package:app/presentation/swiper/swiper.dart';
import 'package:app/presentation/history/screen.dart';
import 'package:app/presentation/util/button.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:app/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SwiperScreen extends StatelessWidget {
  const SwiperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: "CaTinder"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 600,
            child: BlocBuilder<SwiperCubit, SwiperState>(
              builder: (ctx, cat) => SwiperWidget(
                card: CardWidget(card: cat.catFuture),
                onLeftSwipe: () => ctx.read<SwiperCubit>().dislike(),
                onRightSwipe: () => ctx.read<SwiperCubit>().like(),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AppScreen(screen: DetailsScreen(cat: cat.catFuture)),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(
                onPressed: () => context.read<SwiperCubit>().dislike(),
                icon: Icons.clear,
              ),
              BlocBuilder<SwiperCubit, SwiperState>(
                builder: (context, cat) => TextBox(
                  text: GetIt.I.get<HistoryRepository>().likesCount.toString(),
                ),
              ),
              Button(
                onPressed: () => context.read<SwiperCubit>().like(),
                icon: Icons.favorite,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Button(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AppScreen(screen: HistoryScreen()),
            ),
          );
        },
        icon: Icons.menu,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
