import 'package:app/domain/entities/cat.dart';
import 'package:app/presentation/util/textbox.dart';
import 'package:app/presentation/util/netimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CardWidget extends StatelessWidget {
  final Future<Cat> card;

  const CardWidget({
    super.key,
    required this.card,
  });

  Widget _buildLoaded(Cat card, BuildContext context) {
    return Column(
      children: [
        NetImage(url: card.imageUrl),
        TextBox(text: card.breed),
      ],
    );
  }

  Widget _buildError(String error, BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Network error!'),
          content: const Text('Failed to load card'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
    return Center(child: Icon(Icons.error, color: Colors.red));
  }

  Widget _buildLoad(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 500,
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        child: SingleChildScrollView(
          child: FutureBuilder<Cat>(
            future: card,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildLoaded(snapshot.data!, context);
              } else if (snapshot.hasError) {
                return _buildError('${snapshot.error}', context);
              }

              return _buildLoad(context);
            },
          ),
        ),
      ),
    );
  }
}
