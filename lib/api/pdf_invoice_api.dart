import 'dart:io';

import 'package:flutter/services.dart';
import 'package:googleapis/displayvideo/v1.dart';
import 'package:pdf/widgets.dart';
import 'package:proyectobd/api/pdf_api.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
        build: (context) => [
              Container(
                child:
                    Text('Factura', style: TextStyle(font: Font.helvetica())),
              )
            ]));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
