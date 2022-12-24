import 'package:amazon_clone/common/widget/star.dart';
import 'package:amazon_clone/features/admin/services/product.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Image.network(
            product.images[0],
            fit: BoxFit.fill,
            height: 135,
            width: 135,
          ),
          Column(
            children: [
              Container(
                width: 235,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.name,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 225,
                padding: const EdgeInsets.only(top: 10),
                child: Star(
                  rating: avgRating,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "\$${product.price}",
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Text(
                  "Eligible for Free shipping",
                  maxLines: 2,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Text(
                  "In Stock",
                  maxLines: 2,
                  style: TextStyle(color: Colors.teal, fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
