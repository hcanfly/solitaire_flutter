import 'package:flutter/material.dart';

import 'stock_stack.dart';
import 'talon_stack.dart';

// wrapper around Stock and Talon stacks to allow refresh when moving cards between them.
class StockWasteContainer extends StatefulWidget {
  @override
  _StockWasteContainerState createState() => _StockWasteContainerState();
}

class _StockWasteContainerState extends State<StockWasteContainer> {
  Null _refresh(int notUsed) {
    setState(() {
      //something changed in one or both of the children
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TalonStackWidget(parentRefresh: _refresh),
        StockStackWidget(parentRefresh: _refresh),
      ],
    );
  }
}
