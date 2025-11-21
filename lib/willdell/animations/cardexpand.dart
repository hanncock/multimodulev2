import 'package:flutter/material.dart';

class ExpandingCard extends StatefulWidget {
  @override
  _ExpandingCardState createState() => _ExpandingCardState();
}

class _ExpandingCardState extends State<ExpandingCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Always visible
              Text("Invoice"),

              // Expanding section
              if (isExpanded)
                Column(
                  children: [
                    SizedBox(height: 16),
                    Text("More invoice details..."),
                    Text("Totals: \$123.45"),
                  ],
                ),
            ],
          ),
        ),
      )*/

      body: GestureDetector(
        onTap: () => setState(() => isExpanded = !isExpanded),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: isExpanded ? 200 : 100,   // Expanded height vs collapsed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: isExpanded ? 12 : 4,
                color: Colors.black26,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Invoice Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              // Expanding content
              AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: isExpanded ? 1 : 0,
                child: isExpanded
                    ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                      "More details about invoice go here...\nLine items... etc."),
                )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
