import 'package:flutter/material.dart';

class SContainer extends StatefulWidget {
  final double? height;
  final double? margin;
  final double? width;
  final Color? color;
  final Widget? child;
  final double? borderRadius;
  const SContainer({
    super.key,
    this.height,
    this.margin,
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
      margin: EdgeInsets.all(widget.margin ?? 1),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: widget.child,
    );
  }
}
