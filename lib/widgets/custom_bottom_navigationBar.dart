import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function onTap;

  const CustomBottomNavigationBar({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  void _onTap(index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Monthly',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Daily',
        )
      ],
      currentIndex: _currentIndex,
      onTap: _onTap,
    );
  }
}
