import 'package:flutter/material.dart';
import 'package:ortalama_hesaplama/constants/app_constants.dart';

class OrtalamaGoster extends StatelessWidget {
  final double? ortlama;
  final int? dersSayisi;
  const OrtalamaGoster(
      {@required this.ortlama, @required this.dersSayisi, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dersSayisi! > 0 ? '$dersSayisi Ders Girildi' : 'Ders secin',
          style: Sabitler.ortalamaGosterBodyStyle,
        ),
        Text(
          ortlama! >= 0 ? '${ortlama!.toStringAsFixed(2)}' : '0.0',
          style: Sabitler.ortalamaStyle,
        ),
        Text(
          'ortalama',
          style: Sabitler.ortalamaGosterBodyStyle,
        ),
      ],
    );
  }
}
