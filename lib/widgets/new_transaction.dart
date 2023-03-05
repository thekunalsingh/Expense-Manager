import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTx);

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _tittleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _Summision() {
    if (_amountController.text.isEmpty) {
      return;
    }
    ;
    final String EnteredTitle = _tittleController.text;
    final double EnterdAmount = double.parse(_amountController.text);

    if (EnteredTitle.isEmpty || EnterdAmount <= 0 || _selectedDate == null) {
      return;
    } else {
      widget.addTx(
        EnteredTitle,
        EnterdAmount,
        _selectedDate,
      );

      Navigator.of(context).pop();
    }
  }

  void _presentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(
        () {
          _selectedDate = pickedDate;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: const Radius.circular(25.0),
          ),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _tittleController,
                onSubmitted: (_) => _Summision(),

                // onChanged: (value) {
                //   tittleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) => _Summision(),

                // in (_) _ means we are accepting parameter given but there is no use for us.
                // as onsubmitted will give a parameter

                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _selectedDate == null
                          ? Text(
                              "No date Chosen yet ",
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                            )
                          : Text(
                              'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                              style: TextStyle(
                                color: Colors.indigoAccent,
                              ),
                            ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _presentDataPicker,
                            child: const Text(
                              'Chosse Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            )),
                            onPressed: _presentDataPicker,
                            child: const Text(
                              'Chosse Date',
                            ),
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _Summision,
                child: const Text(
                  'Add Transaction',
                  // style: TextStyle(
                  //   color: Theme.of(context).accentColor,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
