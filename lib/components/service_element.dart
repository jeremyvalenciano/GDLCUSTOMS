import 'package:flutter/material.dart';

class ServiceElement extends StatelessWidget {
  final String serviceName;
  final double servicePrice;

  const ServiceElement(
      {Key? key, required this.serviceName, required this.servicePrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 25, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(serviceName),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: 'Precio: '),
                TextSpan(
                  text: '\$$servicePrice',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
