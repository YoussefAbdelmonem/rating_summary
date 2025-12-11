/// Custom Rating Summary with colored indicators
library custom_rating_summary;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// A widget that displays a summary of a rating with colored indicators.
class CustomRatingSummary extends StatelessWidget {
  const CustomRatingSummary({
    Key? key,
    required this.counter,
    this.average = 0.0,
    this.showAverage = true,
    this.averageStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 40,
    ),
    this.counterFiveStars = 0,
    this.counterFourStars = 0,
    this.counterThreeStars = 0,
    this.counterTwoStars = 0,
    this.counterOneStars = 0,
    this.label = 'Ratings',
    this.labelStyle = const TextStyle(fontWeight: FontWeight.w600),
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.space = 20,
    this.thickness = 10,
    this.starColor = Colors.amber,
    this.alignment = CrossAxisAlignment.center,
    this.fiveStarColor = Colors.green,
    this.fourStarColor = Colors.lightGreen,
    this.threeStarColor = Colors.yellow,
    this.twoStarColor = Colors.orange,
    this.oneStarColor = Colors.red,
  }) : super(key: key);

  /// The total number of ratings.
  final int counter;

  /// The average rating.
  final double average;

  /// Whether to show the average rating.
  final bool showAverage;

  /// The style of the [average] rating.
  final TextStyle averageStyle;

  /// The number of ratings with 5 stars.
  final int counterFiveStars;

  /// The number of ratings with 4 stars.
  final int counterFourStars;

  /// The number of ratings with 3 stars.
  final int counterThreeStars;

  /// The number of ratings with 2 stars.
  final int counterTwoStars;

  /// The number of ratings with 1 stars.
  final int counterOneStars;

  /// The label of the [counter]
  final String label;

  /// The style of the [label].
  final TextStyle labelStyle;

  /// The color of the unused stars and the background of the horizontal bar.
  final Color backgroundColor;

  /// The space between the label and the bar.
  final double space;

  /// The thickness of the bar.
  final double thickness;

  /// The color of stars.
  final Color starColor;

  /// The alignment of rating summary.
  final CrossAxisAlignment alignment;

  /// Colors for each star rating
  final Color fiveStarColor;
  final Color fourStarColor;
  final Color threeStarColor;
  final Color twoStarColor;
  final Color oneStarColor;

  Widget _buildStarLabel(int starNumber, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '$starNumber',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CustomReviewBar(
                label: _buildStarLabel(5, fiveStarColor),
                value: counter > 0 ? counterFiveStars / counter : 0.0,
                color: fiveStarColor,
                space: space,
                thickness: thickness,
                backgroundColor: backgroundColor,
              ),
              _CustomReviewBar(
                label: _buildStarLabel(4, fourStarColor),
                value: counter > 0 ? counterFourStars / counter : 0.0,
                color: fourStarColor,
                space: space,
                thickness: thickness,
                backgroundColor: backgroundColor,
              ),
              _CustomReviewBar(
                label: _buildStarLabel(3, threeStarColor),
                value: counter > 0 ? counterThreeStars / counter : 0.0,
                color: threeStarColor,
                space: space,
                thickness: thickness,
                backgroundColor: backgroundColor,
              ),
              _CustomReviewBar(
                label: _buildStarLabel(2, twoStarColor),
                value: counter > 0 ? counterTwoStars / counter : 0.0,
                color: twoStarColor,
                space: space,
                thickness: thickness,
                backgroundColor: backgroundColor,
              ),
              _CustomReviewBar(
                label: _buildStarLabel(1, oneStarColor),
                value: counter > 0 ? counterOneStars / counter : 0.0,
                color: oneStarColor,
                space: space,
                thickness: thickness,
                backgroundColor: backgroundColor,
              ),
            ],
          ),
        ),
        if (showAverage) ...[
          const SizedBox(width: 30),
          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(average.toStringAsFixed(1), style: averageStyle),
                RatingBarIndicator(
                  rating: average,
                  itemSize: 28,
                  unratedColor: backgroundColor,
                  itemBuilder: (context, index) {
                    return Icon(Icons.star, color: starColor);
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "$counter $label",
                  style: labelStyle,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// A widget that displays a horizontal bar with a label.
class _CustomReviewBar extends StatelessWidget {
  const _CustomReviewBar({
    Key? key,
    required this.label,
    required this.value,
    this.color = Colors.amber,
    this.space = 20,
    this.thickness = 10,
    this.backgroundColor = const Color(0xFFEEEEEE),
  }) : super(key: key);

  /// The label of the bar.
  final Widget label;

  /// The progress value of the bar.
  final double value;

  /// The color of the bar.
  final Color color;

  /// The background color of the bar.
  final Color backgroundColor;

  /// The space between the label and the bar.
  final double space;

  /// The thickness of the bar.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 60, child: label), // Fixed width for consistent alignment
          SizedBox(width: space),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: thickness,
                child: LinearProgressIndicator(
                  value: value.isFinite ? value : 0.0,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}