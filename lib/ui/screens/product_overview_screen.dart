import 'package:flutter/material.dart';
import 'package:meals_app/providers/cart.dart';
import 'package:meals_app/providers/products_provider.dart';
import 'package:meals_app/ui/screens/cart_screen.dart';
import 'package:meals_app/ui/widgets/app_drawer.dart';
import 'package:meals_app/ui/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../../providers/product.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_item.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                  // productsContainer.showAll();
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading ? const Center(child: CircularProgressIndicator(),) : ProductGrid(showFavorites: _showFavoritesOnly),
    );
  }
}
