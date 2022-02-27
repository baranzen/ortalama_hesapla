import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ortalama_hesaplama/constants/app_constants.dart';
import 'package:ortalama_hesaplama/helper/data_helper.dart';
import 'package:ortalama_hesaplama/models/ders.dart';
import 'package:ortalama_hesaplama/widgets/ders_listesi.dart';
import 'package:ortalama_hesaplama/widgets/ortalama_goster.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formKey = GlobalKey<FormState>();
  double secilenHarfDeger = 4;
  double secilenKrediDeger = 1;
  String? girilenDersAdi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade100,
        elevation: 0,
        title: Center(
          child: Text(
            Sabitler.appBarBaslik,
            style: Sabitler.appBarBaslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: IntrinsicHeight(
              //!heigtleri aynı yapar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: _buildForm(),
                    ),
                  ),
                  Expanded(
                    //! cross olarak tam tersine genişler
                    child: Container(
                      child: OrtalamaGoster(
                        ortlama: DataHelper.ortalamaHesapla(),
                        dersSayisi: DataHelper.tumEklenenDersler.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              child: DersListesi(
                onDismiss: (a) {
                  setState(() {
                    DataHelper.tumEklenenDersler.removeAt(a);
                  });
                },
              ), //! const yapınca çalılköadı dğişmeyeceği için
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextFormField(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //! burada hata verdi(3)[Solved] Flutter: How to fix “A RenderFlex overflowed by pixels ” error?
              //! horizontal symetric verince sizeboxa gerek kalmıyor
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _buildHarfler(),
                ),
              ),
              /*        const SizedBox(
                width: 10,
              ), */
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _buildKrediler(),
                ),
              ),
              /*          const SizedBox(
                width: 5,
              ), */
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                color: Sabitler.anaRenk,
                onPressed: _dersEkleVeOrtalamaHesaplama,
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          girilenDersAdi = newValue!;
        });
      },
      validator: (deger) {
        if (deger!.length <= 0) {
          return 'Ders adını giriniz.';
        } else
          return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2),
        hintText: 'matematik',
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildHarfler() {
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
            debugPrint(secilenHarfDeger.toString());
          });
        },
        underline: Container(),
      ),
    );
  }

  Widget _buildKrediler() {
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
            debugPrint(secilenKrediDeger.toString());
          });
        },
        underline: Container(),
      ),
    );
  }

  void _dersEkleVeOrtalamaHesaplama() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formKey.currentState!.reset();
      var eklenecekDers = Ders(
        ad: girilenDersAdi!,
        harfDegeri: secilenHarfDeger,
        krediDegeri: secilenKrediDeger,
      );
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
