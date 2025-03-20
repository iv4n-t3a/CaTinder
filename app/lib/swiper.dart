import 'package:app/details.dart';
import 'package:app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Swiper extends StatefulWidget {
  const Swiper({
    super.key,
  });

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  late Future<CatCard> currentCard;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _updateCat();
  }

  void _updateCat() {
    currentCard = fetchCard();
  }

  void _openDetails(CatCard card) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(card: card)),
    );
  }

  void _dislike() {
    setState(() {});
    _updateCat();
  }

  void _like() {
    count += 1;
    setState(() {});
    _updateCat();
  }

  Widget _buildCard(CatCard card) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _openDetails(card),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              _like();
            } else if (direction == DismissDirection.endToStart) {
              _dislike();
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CatImage(url: card.imageUrl),
                    Text(card.breed),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardLoad() {
    return FutureBuilder<CatCard>(
      future: currentCard,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildCard(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("catinder"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCardLoad(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: _dislike,
                child: Icon(
                  Icons.arrow_back,
                  size: 42,
                ),
              ),
              Text(count.toString()),
              FloatingActionButton(
                onPressed: _like,
                child: Icon(
                  Icons.favorite,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
