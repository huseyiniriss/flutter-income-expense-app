import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateButton extends StatelessWidget {
  final DateTime date;
  final String dateFormat;
  final dynamic onTap;

  const DateButton({
    Key? key,
    required this.date,
    required this.dateFormat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.teal,
          ),
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.date_range,
                size: 24,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  DateFormat(dateFormat).format(date),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
