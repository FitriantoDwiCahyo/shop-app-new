import 'package:flutter/material.dart';
import 'package:meals_app/providers/products_provider.dart';
import 'package:meals_app/ui/widgets/product_item.dart';
import 'package:provider/provider.dart';

// import '../../models/product.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorites;
  const ProductGrid({
    Key? key,
    required this.showFavorites
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider?>(context);
    final products = showFavorites? productsData!.favoriteItems : productsData!.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
            // create: (c) => products[index],
            value: products[index],
            child: ProductItem(),
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
