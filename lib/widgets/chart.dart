import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expense_manager/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransaction;
  Chart(this._recentTransaction);

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      double totalSum = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: index));

      for (var i = 0; i < _recentTransaction.length; i++) {
        if (_recentTransaction[i].date.day == weekDay.day &&
            _recentTransaction[i].date.month == weekDay.month &&
            _recentTransaction[i].date.year == weekDay.year) {
          totalSum = totalSum + _recentTransaction[i].amount;
        }
      }
      print('day : ' + DateFormat.E().format(weekDay));
      print('sum : ' + totalSum.toString());
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum = double.parse(sum.toString()) +
          double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(2),
      child: Row(
        children: groupTransactionValue.map((e) {
          return ChartBar(
              e['day'].toString(),
              double.parse(e['amount'].toString()),
              double.parse(e['amount'].toString()) / totalSpending);
        }).toList(),
      ),
    );
  }
}
