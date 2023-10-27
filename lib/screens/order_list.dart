import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
     
    );
  }
}
