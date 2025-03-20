import 'package:app/netimage.dart';
import 'package:flutter/material.dart';
import 'package:app/loader.dart';
import 'package:app/textbox.dart';

class CatCard extends StatelessWidget {
  final Future<CatModel> card;

  const CatCard({
    super.key,
    required this.card,
  });

  Widget _buildLoaded(CatModel card) {
    return Column(
      children: [
        NetImage(url: card.imageUrl),
        TextBox(text: card.breed),
      ],
    );
  }

  Widget _buildError(String error) {
    return TextBox(text: error);
  }

  Widget _buildLoad() {
    return Container(
      alignment: Alignment.center,
      height: 500,
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CatModel>(
      future: card,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildLoaded(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildError('${snapshot.error}');
        }

        return _buildLoad();
      },
    );
  }
}
