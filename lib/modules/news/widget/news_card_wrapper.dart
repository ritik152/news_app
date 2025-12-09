import 'package:flutter/material.dart';

class NewsCardWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const NewsCardWrapper({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<NewsCardWrapper> createState() => _NewsCardWrapperState();
}

class _NewsCardWrapperState extends State<NewsCardWrapper> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails d) {
    setState(() => _scale = 0.96);
  }

  void _onTapUp(TapUpDetails d) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
