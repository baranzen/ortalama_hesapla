import 'package:flutter/material.dart';
import 'package:ortalama_hesaplama/constants/app_constants.dart';
import 'package:ortalama_hesaplama/helper/data_helper.dart';

class HarfDropDownWidget extends StatefulWidget {
  final Function onHarfSecildi;
  const HarfDropDownWidget({required this.onHarfSecildi, Key? key})
      : super(key: key);

  @override
  State<HarfDropDownWidget> createState() => HarfDropDownWidgetState();
}

class HarfDropDownWidgetState extends State<HarfDropDownWidget> {
  double secilenHarfDeger = 4;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
        //! isExpanded: true,(3)
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade300,
        items: DataHelper.tumDersHarfleri(),
        value: secilenHarfDeger,
        onChanged: (secilen) {
          setState(() {
            secilenHarfDeger = secilen!;
            widget.onHarfSecildi(secilenHarfDeger);
          });
        },
        underline: Container(),
      ),
    );
  }
}
