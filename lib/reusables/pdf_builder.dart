import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List> buildInvoicePdf(Map<String, dynamic> formData, List<Map<String, dynamic>> invoiceLines, String companyName) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context ctx) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(companyName, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Issue Date: ${formData['issueDate']}"),
                    pw.Text("Due Date: ${formData['dueDate']}"),
                  ],
                )
              ],
            ),

            pw.SizedBox(height: 20),
            pw.Divider(),

            // Bill To
            pw.Text("BILL TO:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(formData['chargedToName'] ?? ""),

            pw.SizedBox(height: 20),

            // Invoice Title
            pw.Text("INVOICE",
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),

            // Table header
            pw.Container(
              color: PdfColors.grey300,
              padding: const pw.EdgeInsets.all(6),
              child: pw.Row(
                children: [
                  pw.Expanded(flex: 4, child: pw.Text("Description")),
                  pw.Expanded(flex: 1, child: pw.Text("Qty")),
                  pw.Expanded(flex: 2, child: pw.Text("Rate")),
                  pw.Expanded(flex: 2, child: pw.Text("Amount")),
                ],
              ),
            ),

            pw.Divider(),

            // Table rows
            ...invoiceLines.map((line) => pw.Row(
              children: [
                pw.Expanded(flex: 4, child: pw.Text(line['invLineDescr'])),
                pw.Expanded(flex: 1, child: pw.Text("${line['quantity']}")),
                pw.Expanded(flex: 2, child: pw.Text("${line['unitAmnt']}")),
                pw.Expanded(flex: 2, child: pw.Text("${line['totalAmnt']}")),


              ],
            )),

            pw.Divider(),
            pw.SizedBox(height: 20),

            // Totals
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Subtotal: ${formData['amount']}"),
                    pw.Text("Tax: ${formData['tax']}"),
                    pw.SizedBox(height: 10),
                    pw.Text("TOTAL: ${formData['amount']}",
                        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Notes
            pw.Text("Notes:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(formData['notes'] ?? ""),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
