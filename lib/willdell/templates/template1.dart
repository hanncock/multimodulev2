// import 'package:flutter/material.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
//
// class HtmlEditorExample extends StatefulWidget {
//   @override
//   _HtmlEditorExampleState createState() => _HtmlEditorExampleState();
// }
//
// class _HtmlEditorExampleState extends State<HtmlEditorExample> {
//   final HtmlEditorController controller = HtmlEditorController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("HTML Style Editor")),
//       body: Column(
//         children: [
//           Expanded(
//             child: HtmlEditor(
//               controller: controller,
//               htmlEditorOptions: HtmlEditorOptions(
//                 hint: "Type your content...",
//                 shouldEnsureVisible: true,
//               ),
//               htmlToolbarOptions: HtmlToolbarOptions(
//                 defaultToolbarButtons: [
//                   FontButtons(),
//                   ColorButtons(),
//                   ListButtons(),
//                   ParagraphButtons(),
//                   InsertButtons(),
//                 ],
//                 toolbarPosition: ToolbarPosition.aboveEditor,
//               ),
//               otherOptions: OtherOptions(
//                 height: 500,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             child: Text("Get HTML"),
//             onPressed: () async {
//               String html = await controller.getText();
//               print(html); // <p><strong>Hello</strong> world!</p>
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
