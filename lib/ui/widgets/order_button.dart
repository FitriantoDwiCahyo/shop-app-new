import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/orders.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isloading)
          ? null
          : () async {
              setState(() {
                _isloading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isloading = false;
              });
              widget.cart.clear();
            },
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
      ),
      child: _isloading ? const CircularProgressIndicator() : const Text(
        'ORDER NOW',
      ),
    );
  }
}
