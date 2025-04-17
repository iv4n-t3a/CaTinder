import 'package:app/domain/filter.dart';
import 'package:app/domain/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatelessWidget {
  final Widget screen;

  const AppScreen({
    super.key,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SwiperCubit>(
          create: (_) => SwiperCubit(),
        ),
        BlocProvider<FilterCubit>(
          create: (_) => FilterCubit(),
        )
      ],
      child: screen,
    );
  }
}
