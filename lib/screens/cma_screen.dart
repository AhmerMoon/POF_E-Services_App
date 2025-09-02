import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

// Mobile/Desktop imports
import 'dart:io' show File;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

// Web import
import 'dart:typed_data';
import 'dart:html' as html;

class CmaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Generate a list of the last 12 months for the pay slips
    final List<String> months = [
      'AUG-2025',
      'JUL-2025',
      'JUN-2025',
      'MAY-2025',
      'APR-2025',
      'MAR-2025',
      'FEB-2025',
      'JAN-2025',
      'DEC-2024',
      'NOV-2024',
      'OCT-2024',
      'SEP-2024',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('CMA (POFs)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header text for pay slips
                  Text(
                    'Pay Slips',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Description text
                  Text(
                    'This app only provides Pay Slips from the last 12 months. '
                    'Please download and save regularly to avoid any inconvenience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  // List of pay slips
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      return _buildPaySlipItem(context, months[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each pay slip list item
  Widget _buildPaySlipItem(BuildContext context, String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          leading: Icon(Icons.description, color: Colors.black54),
          title: Text(
            month,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          trailing: IconButton(
            icon: Icon(Icons.download, color: Colors.green, size: 30),
            onPressed: () async {
              if (kIsWeb) {
                await _generatePayslipPdfWeb(month);
              } else {
                await _generatePayslipPdfMobile(context, month);
              }
            },
          ),
        ),
      ),
    );
  }

  /// Generate PDF for Mobile/Desktop
  Future<void> _generatePayslipPdfMobile(
    BuildContext context,
    String month,
  ) async {
    final pdf = _buildPdf(month);
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Payslip_$month.pdf");
    await file.writeAsBytes(await pdf.save());

    // Share / Save
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "Payslip_$month.pdf",
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Payslip for $month downloaded')));
  }

  /// Generate PDF for Web
  Future<void> _generatePayslipPdfWeb(String month) async {
    final pdf = _buildPdf(month);
    final Uint8List bytes = await pdf.save();

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
        html.AnchorElement(href: url)
          ..setAttribute("download", "Payslip_$month.pdf")
          ..click();
    html.Url.revokeObjectUrl(url);
  }

  /// Common PDF builder
  pw.Document _buildPdf(String month) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'POF Employee Payslip',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              pw.Text('Employee Name: Ali Khan'),
              pw.Text('Employee ID: EMP123'),
              pw.Text('Designation: Software Engineer'),
              pw.Text('Department: IT'),
              pw.Text('Month: $month'),

              pw.SizedBox(height: 20),
              pw.Divider(),

              pw.Text('Basic Salary: Rs. 50,000'),
              pw.Text('Allowances: Rs. 10,000'),
              pw.Text('Deductions: Rs. 5,000'),

              pw.SizedBox(height: 20),
              pw.Text(
                'Net Salary: Rs. 55,000',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
    return pdf;
  }
}
