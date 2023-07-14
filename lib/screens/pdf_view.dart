
import 'package:flutter/material.dart';

class ViewPDF extends StatefulWidget {
  ViewPDF({super.key, required this.bookurl});
  String bookurl;

  @override
  State<ViewPDF> createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(height: 10), 
      // SfPdfViewer.network(widget.bookurl,
      //     canShowHyperlinkDialog: true,
      //     enableHyperlinkNavigation: true,
      //     canShowScrollHead: false,
      //     pageLayoutMode: PdfPageLayoutMode.continuous,
      //     currentSearchTextHighlightColor:
      //         const Color.fromARGB(80, 249, 125, 0),
      //     otherSearchTextHighlightColor: const Color.fromARGB(50, 255, 255, 1),
      //     interactionMode: PdfInteractionMode.selection,
      //     canShowScrollStatus: false),
    );
  }
}
