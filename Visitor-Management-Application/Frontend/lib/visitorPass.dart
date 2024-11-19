// import 'dart:html';

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:visitor_application/main.dart';
import 'package:visitor_application/navbar.dart';
import 'package:visitor_application/visitor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:universal_html/html.dart' as html;
// import 'dart:typed_data';
// import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorPass extends StatefulWidget {
  final Visitor visitor;
  VisitorPass({required this.visitor});

  @override
  State<VisitorPass> createState() => _VisitorPassState();
}

class _VisitorPassState extends State<VisitorPass> {
  late final PdfImage pdfImage;
  late Uint8List visitorImageBytes;
  @override
  void initState() {
    super.initState();
    _fetchVisitorImage(widget.visitor.image_url);
  }

  Future<void> _fetchVisitorImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        setState(() {
          visitorImageBytes = response.bodyBytes;
        });
      } else {
        print('Failed to fetch visitor image.');
      }
    } catch (error) {
      print('Error fetching visitor image: $error');
    }
  }

  // const ThankYou({super.key});
  Future<void> _printVisitorPass() async {
    if (visitorImageBytes == null) {
      print('Visitor image not fetched yet.');
      return;
    }
    print('Generating PDF..');
    final pdf = pw.Document();

    final pdfImage = PdfImage.file(
      pdf.document,
      bytes: visitorImageBytes,
    );
    final myFont = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
          child: pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#FFB449'),
                  borderRadius: pw.BorderRadius.circular(10),
                  border: pw.Border.all(
                      color: PdfColor.fromHex('#000000'), width: 2)),
              height: 200,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Image(
                            pw.MemoryImage(
                              visitorImageBytes,
                            ),
                            width: 150,
                            height: 150,
                            fit: pw.BoxFit.contain)),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Text(
                                'Name: ',
                                style: pw.TextStyle(font: pw.Font.ttf(myFont)),
                              ),
                              pw.SizedBox(
                                width: 5,
                              ),
                              pw.Text(
                                '${widget.visitor.visitor_name}',
                                style: pw.TextStyle(
                                    font: pw.Font.ttf(myFont),
                                    color: PdfColor.fromHex('#FF2600')),
                                maxLines: null,
                              ),
                            ],
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Text(
                                'Oragnization: ',
                                style: pw.TextStyle(font: pw.Font.ttf(myFont)),
                              ),
                              pw.SizedBox(
                                width: 5,
                              ),
                              pw.Text(
                                '${widget.visitor.visitor_organization}',
                                style: pw.TextStyle(
                                    font: pw.Font.ttf(myFont),
                                    color: PdfColor.fromHex('#FF2600')),
                                maxLines: null,
                              ),
                            ],
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Text(
                                'Email: ',
                                style: pw.TextStyle(font: pw.Font.ttf(myFont)),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                '${widget.visitor.visitor_email}',
                                style: pw.TextStyle(
                                    font: pw.Font.ttf(myFont),
                                    color: PdfColor.fromHex('#FF2600')),
                                maxLines: null,
                              ),
                            ],
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Text(
                                'Mobile no.: ',
                                style: pw.TextStyle(font: pw.Font.ttf(myFont)),
                              ),
                              pw.SizedBox(
                                width: 5,
                              ),
                              pw.Text(
                                '${widget.visitor.visitor_phone_number}',
                                style: pw.TextStyle(
                                    font: pw.Font.ttf(myFont),
                                    color: PdfColor.fromHex('#FF2600')),
                                maxLines: null,
                              ),
                            ],
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Text(
                                'Here to meet: ',
                                style: pw.TextStyle(font: pw.Font.ttf(myFont)),
                              ),
                              pw.SizedBox(
                                width: 5,
                              ),
                              pw.Text(
                                '${widget.visitor.visitor_whom_meet}',
                                style: pw.TextStyle(
                                    font: pw.Font.ttf(myFont),
                                    color: PdfColor.fromHex('#FF2600')),
                                maxLines: null,
                              ),
                            ],
                          ),
                          pw.BarcodeWidget(
                            data:
                                "Name: ${widget.visitor.visitor_name}, Organization: ${widget.visitor.visitor_organization}, Email: ${widget.visitor.visitor_email}, Phone No.: ${widget.visitor.visitor_phone_number}, Here to meet: ${widget.visitor.visitor_whom_meet}",
                            barcode: pw.Barcode.qrCode(),
                            width: 60,
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ])));
    }));
    print('generated pdf');
    // return pdf;

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // Future<void> printVisitorPassPDF(pw.Document pdf) async {
  //   final pdfData = await pdf.save();
  //   await Printing.layoutPdf(onLayout: (format) => pdfData);
  // }

  // Future<void> viewVisitorPassPDF() async {
  //   try {
  //     print('Generating PDF...');
  //     final pdf = await _printVisitorPass();

  //     final pdfdata = await pdf.save();
  //     print('pdf data generated');
  //     // ignore: use_build_context_synchronously
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PDFView(
  //             pdfData: pdfdata,
  //             // pdfData: pdfdata,
  //             enableSwipe: true,
  //           ),
  //         ));
  //     print('printing pdf');
  //     await printVisitorPassPDF(pdf);
  //     print('pdf orinted');
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF6e5), Color(0xFFF39D23)],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Navbar(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            title:
                // SizedBox(
                //   height: 50,
                // ),
                Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              // height: 500,
              width: 200,
            ),
          ),
        ),
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'New Visitor',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFFFE4C2D),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(
                color: Color(0xFFF39D23),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                      color: Color(0xFFFFB449),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Color(0xFFC8102E),
                            width: 1.0,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(widget.visitor.image_url),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Name: ',
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${widget.visitor.visitor_name}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFFC8102E)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Oragnization: ',
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${widget.visitor.visitor_organization}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFFC8102E)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Email: ',
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${widget.visitor.visitor_email}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFFC8102E)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Mobile no.: ',
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${widget.visitor.visitor_phone_number}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFFC8102E)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Here to meet: ',
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${widget.visitor.visitor_whom_meet}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFFC8102E)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                                QrImageView(
                                  data:
                                      "Name: ${widget.visitor.visitor_name}, Organization: ${widget.visitor.visitor_organization}, Email: ${widget.visitor.visitor_email}, Phone No.: ${widget.visitor.visitor_phone_number}, Here to meet: ${widget.visitor.visitor_whom_meet}",
                                  version: QrVersions.auto,
                                  size: 65.0,
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              _printVisitorPass();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => VisitorsListPage(),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFFFFF),
                                side: BorderSide(
                                    width: 1.0, color: Color(0xFFFF5C00)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              'Print Visitor Pass',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFFF39D23),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondRoute(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFFFFF),
                                side: BorderSide(
                                    width: 1.0, color: Color(0xFFFF5C00)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              'Add new Visitor',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFFF39D23),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
