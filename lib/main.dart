import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Quicksand',
        accentColor: Colors.indigo,
        primaryColor: Color(0xFF9fb7eb),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  void _removeTransaction(String txId) {
    setState(() {
      _userTransactions.removeWhere((item) => item.id == txId);
    });
  }

  void _addTransaction(String txTitle, double txAmount, DateTime date) {
    Random random = new Random();
    final newTx = Transaction(
      date: date,
      amount: txAmount,
      id: '${DateTime.now()}-${random.nextInt(100)}',
      title: txTitle,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _StartAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return NewTransaction(
          _addTransaction,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(
              days: 7,
            ),
          ),
        );
      },
    ).toList();
  }

  bool _showChart = false;

  List<Widget> _builderLandscapeContent(
    MediaQueryData mediaQueryContext,
    AppBar appBar,
    Widget txList,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Show Expenses Chart',
            // style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQueryContext.size.height -
                      appBar.preferredSize.height -
                      mediaQueryContext.padding.top) *
                  0.7,
              child: Chart(
                _recentTransactions,
              ),
            )
          : txList,
    ];
  }

  List<Widget> _builderPortraitContent(
    MediaQueryData mediaQueryContext,
    AppBar appBar,
    Widget txList,
  ) {
    return [
      Container(
        height: (mediaQueryContext.size.height -
                appBar.preferredSize.height -
                mediaQueryContext.padding.top) *
            0.3,
        child: Chart(
          _recentTransactions,
        ),
      ),
      txList,
    ];
  }

  Widget _builderCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: const Text(
        'Personal Expenses',
      ),
      trailing: Row(
        children: <Widget>[
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => _StartAddNewTransaction(context),
          )
        ],
      ),
    );
  }

  Widget _builderMaterialAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () => _StartAddNewTransaction(context),
          icon: const Icon(
            Icons.add,
            color: Color(0xFF9fb7eb),
          ),
        ),
      ],
      title: const Text(
        'Personal Expenses',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryContext = MediaQuery.of(context);
    final _islandscape = mediaQueryContext.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _builderCupertinoAppBar() : _builderMaterialAppBar();
    final txList = Container(
      height: (mediaQueryContext.size.height -
              appBar.preferredSize.height -
              mediaQueryContext.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        removeTrans: _removeTransaction,
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // IMPORTAMT:: you dont use curly braces({}) after if in this case. its special"if inside alist" syntax
            if (_islandscape)
              ..._builderLandscapeContent(
                  mediaQueryContext, appBar, txList), // .. used spread operator
            if (!_islandscape)
              ..._builderPortraitContent(mediaQueryContext, appBar, txList),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                    ),
                    onPressed: () => _StartAddNewTransaction(context),
                  ),
          );
  }
}
