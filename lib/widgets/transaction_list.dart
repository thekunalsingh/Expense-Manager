import 'package:flutter/rendering.dart';

import '../models/transaction.dart';
import '../widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTrans;

  TransactionList({
    @required this.transactions,
    @required this.removeTrans,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, Constraints) {
                final constraintsMaxHeight = Constraints.maxHeight;
                return Column(
                  children: [
                    SizedBox(
                      height: constraintsMaxHeight * 0.05,
                    ),
                    Container(
                      height: constraintsMaxHeight * 0.15,
                      child: Text(
                        "No Transactions yet !!",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(
                      height: constraintsMaxHeight * 0.05,
                    ),
                    Container(
                      height: constraintsMaxHeight * 0.75,
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionCard(
                  amount: transactions[index].amount,
                  date: transactions[index].date,
                  id: transactions[index].id,
                  title: transactions[index].title,
                  removeTrans: removeTrans,
                );
              },
              itemCount: transactions.length,
            ),
    );

    // return Column(
    //   children: transactions.map(
    //     (tx) {
    //       return Card(
    //         child: Row(
    //           children: <Widget>[
    //             Container(
    //               margin: EdgeInsets.symmetric(
    //                 vertical: 10,
    //                 horizontal: 15,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.purple,
    //                   width: 2,
    //                 ),
    //               ),
    //               padding: EdgeInsets.all(10),
    //               child: Text(
    //                 '\$${tx.amount}',
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20,
    //                   color: Colors.purple,
    //                 ),
    //               ),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   tx.title,
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Text(
    //                   DateFormat.yMMMd().format(tx.date),
    //                   style: TextStyle(
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     removeTrans(
    //                       tx.id,
    //                     );
    //                   },
    //                   child: Text(
    //                     'Delete',
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ).toList(),
    // );
  }
}
