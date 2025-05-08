import 'package:app/data/netchecker/netobserver.dart';
import 'package:app/domain/repositories/history.dart';
import 'package:app/domain/swiper.dart';
import 'package:app/presentation/details/screen.dart';
import 'package:app/presentation/swiper/card.dart';
import 'package:app/presentation/history/screen.dart';
import 'package:app/presentation/util/button.dart';
import 'package:app/presentation/util/swipable.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:app/presentation/util/no_internet_notify.dart';
import 'package:app/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SwiperScreen extends StatefulWidget {
  const SwiperScreen({super.key});

  @override
  State<SwiperScreen> createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  NetworkStatusObserver? netobserver;

  @override
  void initState() {
    super.initState();
    netobserver = NetworkStatusObserver(onNoInternet: () => notifyNoInternet(context));
  }

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
              builder: (ctx, cat) => Swipable(
                child: CardWidget(card: cat.catFuture),
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
              GestureDetector(
                child: BlocBuilder<SwiperCubit, SwiperState>(
                  builder: (context, cat) => FutureBuilder(
                    future: GetIt.I.get<HistoryRepository>().likesCount,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      } else if (snapshot.hasError) {
                        return const SizedBox.shrink();
                      } else {
                        return TextBox(text: snapshot.data!.toString());
                      }
                    },
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AppScreen(screen: HistoryScreen()),
                    ),
                  );
                },
              ),
              Button(
                onPressed: () => context.read<SwiperCubit>().like(),
                icon: Icons.favorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

