import 'package:flutter/material.dart';
import 'package:ortalama_hesaplama/constants/app_constants.dart';
import 'package:ortalama_hesaplama/helper/data_helper.dart';

class KrediDropDownWidget extends StatefulWidget {
  final Function onKrediSecildi;
  const KrediDropDownWidget({required this.onKrediSecildi, Key? key})
      : super(key: key);

  @override
  State<KrediDropDownWidget> createState() => _KrediDropDownWidgetState();
}

class _KrediDropDownWidgetState extends State<KrediDropDownWidget> {
  double secilenKrediDeger = 1;
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
        items: DataHelper.tumKrediler(),
        value: secilenKrediDeger,
        onChanged: (secilen) {
          setState(() {
            secilenKrediDeger = secilen!;
            widget.onKrediSecildi(secilenKrediDeger);
          });
        },
        underline: Container(),
      ),
    );
  }
}
