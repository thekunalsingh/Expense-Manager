import '../models/transaction.dart';
import 'package:flutter/material.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(
            days: index,
          ),
        );

        var totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
          ;
        }
        ;
        return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      },
    ).reversed.toList();
  }

  double get totalmaxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).accentColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            final constraintsMaxHeight = constraints.maxHeight;

            return Column(
              children: [
                Container(
                  height: constraintsMaxHeight * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: groupedTransactionValues.map(
                      (data) {
                        return Flexible(
                          fit: FlexFit.tight,
                          child: ChartBar(
                            label: data['day'],
                            spendingAmount: data['amount'],
                            spendingPercentageOfTotal: totalmaxSpending == 0.0
                                ? 0.0
                                : (data['amount'] as double) / totalmaxSpending,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: constraintsMaxHeight * 0.05,
                ),
                Container(
                  height: constraintsMaxHeight * 0.15,
                  child: FittedBox(
                    child: Text(
                      'Total spend : ₹$totalmaxSpending',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
