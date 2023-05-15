import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:proyectobd/classes/service_class.dart';

import '../admin/admin_login.dart';

double subtotal = 0;
double iva = 0;
double totalFinal = 0;
List<Service> servicesT = [];

String formatNumberWithCommas(int number) {
  // Convierte el número a string y lo divide en dos partes:
  // la parte entera y la parte decimal (si existe)
  String stringValue = number.toString();
  List<String> parts = stringValue.split('.');

  // Agrega comas a la parte entera
  RegExp regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  parts[0] = parts[0].replaceAllMapped(regex, (Match match) => '${match[1]},');

  // Si hay parte decimal, la agrega de nuevo al número formateado
  if (parts.length == 2) {
    return '${parts[0]}.${parts[1]}';
  } else {
    return parts[0];
  }
}

class PdfPreviewPage extends StatelessWidget {
  final String clientName;
  final String clientAddress;
  final String clientPhoneNumber;
  final String clientEmail;
  final String employeeName;
  final String carModel;
  final String licensePlate;
  final int requestId;
  final double sparePartsCost;
  final double extraCost;
  final double total;
  const PdfPreviewPage(
      {Key? key,
      required this.clientName,
      required this.clientPhoneNumber,
      required this.clientEmail,
      required this.employeeName,
      required this.sparePartsCost,
      required this.extraCost,
      required this.total,
      required this.carModel,
      required this.clientAddress,
      required this.licensePlate,
      required this.requestId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getServiceByRequestId();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview de Ticket'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  getServiceByRequestId() async {
    Future<List<Service>> futureServices =
        dbHelper.getServicesByRequestId(requestId);
    futureServices.then((services) {
      servicesT = services;
    });
    subtotal = total;
    iva = subtotal * .16;
    totalFinal = subtotal + iva;
    String nomb = formatNumberWithCommas(subtotal.toInt());
    debugPrint('Subtotal: $nomb');
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/images/Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    String now = DateTime.now().toString();
    String nowWithoutMilliseconds = now.substring(0, now.length - 7);

    // Company Information
    final company = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Taller Mecanico "Las tres cruces"'),
        pw.Text(
            'C. Andrés Balvanera 1236, Echeverría, 44970 Guadalajara, Jal.'),
        pw.Text('+523336632629'),
        pw.Text('RFC: PEHM750716MQ3'),
        pw.Text('Fecha Generacion: $nowWithoutMilliseconds'),
      ],
    );

    // Customer Information
    final customer = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Nombre del Cliente: $clientName'),
        pw.Text('Direccion: $clientAddress'),
        pw.Text('Numero Telefonico: $clientPhoneNumber'),
        pw.Text('Email: $clientEmail'),
        pw.Text('Auto: $carModel'),
        pw.Text('Placas: $licensePlate'),
      ],
    );

    // Table Header
    final headers = ['Servicio', 'Descripción', 'Costo'];
    final tableHeader = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        for (var header in headers)
          pw.Text(header, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );

    // Table Content
    final rows = [
      for (var service in servicesT)
        [
          service.name,
          service.description,
          service.serviceCost.toString(),
        ]
    ];

    final tableContent = pw.Column(
      children: [
        tableHeader,
        for (var row in rows)
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              for (var item in row) pw.Text(item),
            ],
          ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Costo Refacciones: $sparePartsCost'),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Costo Extra: $extraCost'),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Subtotal: $subtotal'),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('IVA: $iva'),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Total: $totalFinal',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ],
    );

    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      company,
                      pw.Image(pw.MemoryImage(byteList),
                          fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                customer,
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                tableContent,
              ]);
        }));
    return pdf.save();
  }
}
