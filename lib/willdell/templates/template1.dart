import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class RichEditorExample extends StatefulWidget {
  @override
  _RichEditorExampleState createState() => _RichEditorExampleState();
}

class _RichEditorExampleState extends State<RichEditorExample> {
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rich Text Editor")),
      body: Column(
        children: [
          quill.QuillToolbar.basic(
            controller: _controller,
            showFontFamily: true,   // 👈 enables font selection
            showFontSize: true,     // 👈 enables font sizing
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: quill.QuillEditor.basic(
                controller: _controller,
                readOnly: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
