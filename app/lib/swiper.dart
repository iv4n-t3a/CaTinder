import 'package:app/details.dart';
import 'package:flutter/material.dart';
import 'package:app/loader.dart';

class Swiper extends StatefulWidget {
  const Swiper({
    super.key,
  });

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  late Future<CatCard> currentCard;
  late Image catImage;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _updateCat();
  }

  void _updateCat() {
    currentCard = fetchCard();

    currentCard.then(
      (value) {
        catImage = _buildCatImage(value.imageUrl);
      },
    );
  }

  void _openDetails(CatCard card) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Details(image: catImage, card: card)),
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

  Image _buildCatImage(String url) {
    return Image(
      image: NetworkImage(url),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 500,
    );
  }

  Widget _buildCard() {
    return FutureBuilder<CatCard>(
      future: currentCard,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => _openDetails(snapshot.data!),
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
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          catImage,
                          Text(snapshot.data!.breed),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCard(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: _dislike,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.arrow_back,
                size: 42,
                color: Colors.black,
              ),
            ),
            Text(count.toString()),
            FloatingActionButton(
              onPressed: _like,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.favorite,
                size: 32,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
