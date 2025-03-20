import 'package:app/loader.dart';
import 'package:app/netimage.dart';
import 'package:flutter/material.dart';
import 'package:app/textbox.dart';

class Details extends StatelessWidget {
  final Future<CatModel> card;

  const Details({
    super.key,
    required this.card,
  });

  Widget _buildLoaded(CatModel card) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: card.breed),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NetImage(url: card.imageUrl),
                  TextBox(text: card.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String error) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: error),
        centerTitle: true,
      ),
      body: TextBox(text: error),
    );
  }

  Widget _buildLoad() {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: "Loading..."),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        height: 500,
        child: const CircularProgressIndicator(),
      ),
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
