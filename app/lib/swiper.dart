import 'package:app/details.dart';
import 'package:flutter/material.dart';
import 'package:app/card.dart';
import 'package:app/loader.dart';
import 'package:app/textbox.dart';

class Swiper extends StatefulWidget {
  const Swiper({
    super.key,
  });

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  late Future<CatModel> currentCard;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _updateCat();
  }

  void _updateCat() {
    currentCard = fetchCard();
  }

  void _openDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(card: currentCard)),
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

  Widget _buildCard() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _openDetails(),
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
                child: CatCard(card: currentCard),
              ),
            ),
          ),
        ),
      ),
    );
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
            child: _buildCard(),
          ),
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
              TextBox(text: count.toString()),
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
