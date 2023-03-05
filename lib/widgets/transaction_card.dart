import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Function removeTrans;

  TransactionCard({
    this.title,
    this.id,
    this.amount,
    this.date,
    this.removeTrans,
  });

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: themeContext.accentColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Container(
              height: 20,
              child: FittedBox(
                child: Text(
                  '₹${amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: themeContext.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(date),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () {
                  removeTrans(
                    id,
                  );
                },
                icon: Icon(
                  Icons.delete,
                  size: 35,
                  color: themeContext.errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: themeContext.errorColor,
                  ),
                ),
              )
            : IconButton(
                onPressed: () {
                  removeTrans(
                    id,
                  );
                },
                icon: Icon(
                  Icons.delete,
                  size: 35,
                  color: themeContext.errorColor,
                ),
              ),
      ),
    );
    //   },
    // );
    // return Card(
    //   shape: RoundedRectangleBorder(
    //     // side: BorderSide(color: Theme.of(context).accentColor, width: 1),
    //     borderRadius: BorderRadius.circular(15),
    //   ),
    //   elevation: 4,
    //   margin: EdgeInsets.all(15),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: <Widget>[
    //       Container(
    //         margin: EdgeInsets.symmetric(
    //           vertical: 10,
    //           horizontal: 15,
    //         ),
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: Theme.of(context).primaryColor,
    //             width: 2,
    //           ),
    //         ),
    //         padding: EdgeInsets.all(10),
    //         child: Text(
    //           '₹${amount.toStringAsFixed(2)}',
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             title,
    //             style: Theme.of(context).textTheme.headline6,
    //           ),
    //           Text(
    //             DateFormat.yMMMd().format(date),
    //             style: TextStyle(
    //               color: Colors.grey,
    //             ),
    //           ),
    //           // ElevatedButton(
    //           //   onPressed: () {
    //           //     removeTrans(
    //           //       id,
    //           //     );
    //           //   },
    //           //   child: Text(
    //           //     'Delete',
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //       IconButton(
    //         onPressed: () {
    //           removeTrans(
    //             id,
    //           );
    //         },
    //         icon: Icon(
    //           Icons.delete_outlined,
    //           size: 35,
    //           color: Theme.of(context).accentColor,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
