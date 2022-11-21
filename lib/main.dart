// ignore_for_file: prefer_const_constructors, unused_import

import 'package:expenseapp/Widgets/new_transactions.dart';
import './Widgets/chart.dart';
import '../models/transcations.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/transactions_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          // ignore: deprecated_member_use
          accentColor: Colors.amberAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
              toolbarTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))
                  .bodyText2,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))
                  .headline6)),
      home: MyAppHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  const MyAppHomePage({super.key});

  @override
  State<MyAppHomePage> createState() => _MyAppHomePageState();
}

class _MyAppHomePageState extends State<MyAppHomePage> {
  final List<Transactions> _usertransactions = [
    Transactions(
      id: '5234',
      amount: 99.9,
      title: 'Petrol',
      date: DateTime.now(),
    ),
    Transactions(
      id: '5235',
      amount: 10.5,
      title: 'Recharge',
      date: DateTime.now(),
    ),
  ];
  List<Transactions> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newtx = Transactions(
        id: DateTime.now().toString(),
        amount: txamount,
        title: txtitle,
        date: chosenDate);
    setState(() {
      _usertransactions.add(newtx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((((tx) => tx.id == id)));
    });
  }

  void _startnewTransactions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransactions(_addTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Expense Monitor',
          ),
          actions: [
            IconButton(
                onPressed: (() => _startnewTransactions(context)),
                icon: Icon(Icons.add))
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionsList(_usertransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _startnewTransactions(context),
          child: Icon(Icons.add)),
    );
  }
}
