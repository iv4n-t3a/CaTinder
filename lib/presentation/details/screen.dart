import 'package:app/domain/entities/cat.dart';
import 'package:app/presentation/util/netimage.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Future<Cat> cat;

  const DetailsScreen({
    super.key,
    required this.cat,
  });

  Widget _buildLoaded(Cat card) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: card.breed),
        centerTitle: true,
      ),
      body: Padding(
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
    return FutureBuilder<Cat>(
      future: cat,
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
