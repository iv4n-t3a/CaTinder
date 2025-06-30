import 'package:app/domain/entities/cat.dart';
import 'package:app/presentation/util/netimage.dart';
import 'package:app/presentation/util/network_error.dart';
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
              NetImage(url: card.imageUrl, height: null),
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
        title: TextBox(text: "Network error:("),
        centerTitle: true,
      ),
      body: NetworkError(),
    );
  }

  Widget _buildLoad() {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(text: "Detailed info"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
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
