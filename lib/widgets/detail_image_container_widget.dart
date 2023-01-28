import 'package:flutter/material.dart';

class DetailImageContainer extends StatelessWidget {
  final String imageUrl;
  final Offset offset;

  const DetailImageContainer({
    super.key,
    required this.imageUrl,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: offset,
            color: Colors.black.withOpacity(0.5),
          )
        ],
      ),
      child: Image.network(imageUrl),
    );
  }
}
