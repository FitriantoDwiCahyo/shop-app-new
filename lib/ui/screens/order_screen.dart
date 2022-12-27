import 'package:flutter/material.dart';
import 'package:meals_app/ui/widgets/app_drawer.dart';
import 'package:meals_app/ui/widgets/order_widget_item.dart';
import 'package:provider/provider.dart';

import '../../providers/orders.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderWidgetItem(
          order: orderData.orders[i],
        ),
      ),
    );
  }
}
