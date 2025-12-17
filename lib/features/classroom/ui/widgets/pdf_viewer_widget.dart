import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MedTrixPdfViewer extends StatelessWidget {
  const MedTrixPdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    // Loads a sample PDF from the web for the demo
    return SfPdfViewer.network(
      'https://cdn.syncfusion.com/content/pdf/pdf-succinctly.pdf',
      pageLayoutMode: PdfPageLayoutMode.continuous,
      enableDoubleTapZooming: false, // Disable to prevent conflicts with drawing
      enableTextSelection: false,    // Disable to prioritize drawing
    );
  }
}
