import 'package:flutter/material.dart';


class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    const double fieldHeight = 50;
    const double fieldWidth = 340;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email Address",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: fieldWidth,
            height: fieldHeight,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "sokesoke10725@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Create a Password",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: fieldWidth,
            height: fieldHeight,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9C4), // light yellow
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: _obscureText,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "•••••••••••••••••••",
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),

                ],
              ),
            ),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF0F172A),
              ),
            ),
          )
        ],
      ),
    );
  }
}
