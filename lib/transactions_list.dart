// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenseapp/models/transcations.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactionList;
  final Function _deleteTx;
// ignore: prefer_const_constructors_in_immutables
  TransactionsList(this.transactionList, this._deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: transactionList.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(7),
                            child: FittedBox(
                                child:
                                    Text('₹${transactionList[index].amount}'))),
                      ),
                      title: Text(
                        transactionList[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactionList[index].date),
                      ),
                      trailing: IconButton(
                          onPressed: () => _deleteTx(transactionList[index].id),
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Theme.of(context).errorColor,
                          )),
                    ));
              },
              itemCount: transactionList.length,
            ),
    );
  }
}
