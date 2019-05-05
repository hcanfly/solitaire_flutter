import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'board_info.dart';
import 'stack_widgets/foundation_stack.dart';
import 'stack_widgets/stock_waste_container.dart';
import 'stack_widgets/tableau_stack.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solitaire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Solitaire'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initializeDeck();
  }

  @override
  Widget build(BuildContext context) {
    cardSpacing = (MediaQuery.of(context).size.width) > 750 ? 10.0 : 3.0;
    cardWidth = (MediaQuery.of(context).size.width - (7.0 * cardSpacing)) / 7.0;
    cardHeight = cardWidth * 1.42;
    itemScale = (MediaQuery.of(context).size.width / 375.0);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF004D2C),
      ),
      body: Container(
        color: const Color(0xFF004D2C),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 10.0,
              height: 24.0 * itemScale,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(left: scaled(2)),
                    child: Text(
                      "New Deal",
                      style: TextStyle(
                        fontSize: scaled(16),
                        fontFamily: gameFontFamily,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  splashColor: Colors.white,
                  onTap: () {
                    setState(() {
                      dealCards();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
              height: scaled(18),
            ),
            Padding(
              padding: EdgeInsets.only(left: scaled(2), right: scaled(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.58,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: scaled(2)),
                          child: FoundationStackWidget(stackIndex: 0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: scaled(2)),
                          child: FoundationStackWidget(stackIndex: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: scaled(2)),
                          child: FoundationStackWidget(stackIndex: 2),
                        ),
                        FoundationStackWidget(stackIndex: 3),
                      ],
                    ),
                  ),
                  StockWasteContainer(),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
              height: scaled(16),
            ),
            Padding(
              padding: EdgeInsets.only(left: scaled(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TableauStackWidget(stackIndex: 0),
                  ),
                  Expanded(
                    child: TableauStackWidget(stackIndex: 1),
                  ),
                  Expanded(
                    child: TableauStackWidget(stackIndex: 2),
                  ),
                  Expanded(
                    child: TableauStackWidget(stackIndex: 3),
                  ),
                  Expanded(
                    child: TableauStackWidget(stackIndex: 4),
                  ),
                  Expanded(
                    child: TableauStackWidget(stackIndex: 5),
                  ),
                  Expanded(
                    child: TableauStackWidget(stackIndex: 6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
