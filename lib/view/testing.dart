import 'package:flutter/material.dart';

class AnimatedBoxListScreen extends StatefulWidget {
  @override
  _AnimatedBoxListScreenState createState() => _AnimatedBoxListScreenState();
}

class _AnimatedBoxListScreenState extends State<AnimatedBoxListScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentIndex = 0;
  final double boxWidth = 120;
  final double padding = 10;

  void _scrollToIndex(int index) {
    final position = index * (boxWidth + padding);
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
      // Swiping left
      if (currentIndex < 9) {
        setState(() {
          currentIndex++;
        });
        _scrollToIndex(currentIndex);
      }
    } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      // Swiping right
      if (currentIndex > 0) {
        setState(() {
          currentIndex--;
        });
        _scrollToIndex(currentIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Box List'),
      ),
      body: Center(
        child: GestureDetector(
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(), // Disable user scrolling
            itemCount: 10,
            itemBuilder: (context, index) {
              bool isFocused = index == currentIndex;
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: boxWidth,
                height: isFocused ? 200 : 100, // Long height if focused
                margin: EdgeInsets.symmetric(horizontal: padding),
                decoration: BoxDecoration(
                  color: isFocused ? Colors.teal[400] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Box ${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
