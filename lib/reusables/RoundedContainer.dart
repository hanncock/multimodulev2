import 'package:flutter/material.dart';

class SContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Widget? child;
  final double? borderRadius;
  const SContainer({
    super.key,
    this.height,
    this.width,
    this.color,
    this.child,
    this.borderRadius
  });

  @override
  State<SContainer> createState() => _SContainerState();
}

class _SContainerState extends State<SContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10)
      ),
      child: widget.child,
    );
  }
}
