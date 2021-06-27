import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, required this.onRatingChanged, required this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme
            .of(context)
            .buttonColor,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: Theme
            .of(context)
            .primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: Theme
            .of(context)
            .primaryColor,
      );
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () =>
          onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(
        starCount, (index) => buildStar(context, index)));
  }
}

class TestStar extends StatefulWidget {
  late _TestStarState state;

  @override
  _TestStarState createState() {
    state = new _TestStarState();
    return state;
  }

  double getRating() {
    return state.getRating();
  }

  void setRanking(double ranking) {
    state.rating = ranking;
  }
}

class _TestStarState extends State<TestStar> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return new StarRating(
      rating: rating,
      color: Colors.yellow,
      onRatingChanged: (rating) => setState(() => this.rating = rating),
    );
  }

  void _ratingChanged(rating) {
    this.rating = rating;
    // TODO  backend connection
  }

  double getRating() {
    return rating;
  }
}

