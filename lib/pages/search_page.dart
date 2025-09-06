import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          children: [
            SizedBox(height: 50),
            Expanded(
              child: Image.asset('assets/images/s.jpg', fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
