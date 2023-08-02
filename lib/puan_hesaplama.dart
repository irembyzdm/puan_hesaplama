import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SinavPuanHesaplamaScreen extends StatefulWidget {
  final String sinavAdi;

  SinavPuanHesaplamaScreen(this.sinavAdi);

  @override
  _SinavPuanHesaplamaScreenState createState() =>
      _SinavPuanHesaplamaScreenState();
}

class _SinavPuanHesaplamaScreenState extends State<SinavPuanHesaplamaScreen> {
  List<String> dersler = [];
  List<double> dogruSayilari = [];
  List<double> yanlisSayilari = [];
  List<double> bosSayilari = [];
  double puan = 0;

  @override
  void initState() {
    super.initState();
    if (widget.sinavAdi == 'TYT') {
      dersler = ['Matematik', 'Türkçe', 'Sosyal Bilimler', 'Fen Bilimleri'];
    } else if (widget.sinavAdi == 'AYT') {
      dersler = [
        'Türk Dili ve Edebiyatı - Sosyal Bilimler 1',
        'Sosyal Bilimler 2',
        'Matematik',
        'Fen Bilimleri'
      ];
    } else if (widget.sinavAdi == 'ALES') {
      dersler = ['Sözel', 'Sayısal'];
    } else if (widget.sinavAdi == 'YDS' || widget.sinavAdi == 'YÖKDİL') {
      dersler = ['Yabancı Dil'];
    } else if (widget.sinavAdi == 'DGS') {
      dersler = ['Sayısal', 'Sözel'];
    } else if (widget.sinavAdi == 'KPSS') {
      dersler = [
        'Genel Yetenek',
        'Genel Kültür',
        'Eğitim Bilimleri',
        'Hukuk',
        'İktisat',
        'İşletme',
        'Maliye',
        'Muhasebe',
        'Çalışma Ekonomisi',
        'İstatistik',
        'Kamu Yönetimi',
        'Uluslararası İlişkiler',
      ];
    } else if (widget.sinavAdi == 'DUS') {
      dersler = ['Temel Bilimler', 'Klinik Bilimler'];
    } else if (widget.sinavAdi == 'TUS') {
      dersler = ['Temel Tıp Bilimleri', 'Klinik Tıp Bilimleri'];
    } else if (widget.sinavAdi == 'EKPSS') {
      dersler = ['Genel Yetenek', 'Genel Kültür'];
    }

    for (int i = 0; i < dersler.length; i++) {
      dogruSayilari.add(0);
      yanlisSayilari.add(0);
      bosSayilari.add(0);
    }
  }

  double calculateTYTPuan() {
    double toplamDogru = 0;
    double toplamYanlis = 0;

    for (int i = 0; i < dersler.length; i++) {
      if (dersler[i] == 'Türkçe' ||
          dersler[i] == 'Matematik' ||
          dersler[i] == 'Sosyal Bilimler' ||
          dersler[i] == 'Fen Bilimleri') {
        toplamDogru += dogruSayilari[i];
        toplamYanlis += yanlisSayilari[i];
      }
    }

    return (toplamDogru / 40) * 100 - (toplamYanlis * 0.25);
  }

  double calculateAYTPuan() {
    double toplamDogru = 0;
    double toplamYanlis = 0;

    for (int i = 0; i < dersler.length; i++) {
      if (dersler[i] == 'Türk Dili ve Edebiyatı - Sosyal Bilimler 1' ||
          dersler[i] == 'Sosyal Bilimler 2' ||
          dersler[i] == 'Matematik' ||
          dersler[i] == 'Fen Bilimleri') {
        toplamDogru += dogruSayilari[i];
        toplamYanlis += yanlisSayilari[i];
      }
    }

    return (toplamDogru / 40) * 100 - (toplamYanlis * 0.25);
  }

  double calculateYDSPuan() {
    double toplamDogru = 0;

    for (int i = 0; i < dersler.length; i++) {
      if (dersler[i] == 'Yabancı Dil') {
        toplamDogru += dogruSayilari[i];
      }
    }

    return toplamDogru * 1.25;
  }

  double calculateKPSSPuan() {
    double genelYetenekDogru = dogruSayilari[0];
    double genelYetenekYanlis = yanlisSayilari[0];
    double genelKulturDogru = dogruSayilari[1];
    double genelKulturYanlis = yanlisSayilari[1];

    double genelYetenekPuan =
        (genelYetenekDogru - genelYetenekYanlis * 0.25) * 100 / 80;
    double genelKulturPuan =
        (genelKulturDogru - genelKulturYanlis * 0.25) * 100 / 80;

    // 100 den büyük olmamalı
    genelYetenekPuan = genelYetenekPuan > 100 ? 100 : genelYetenekPuan;
    genelKulturPuan = genelKulturPuan > 100 ? 100 : genelKulturPuan;

    double kpssPuan = (genelYetenekPuan * 0.3) + (genelKulturPuan * 0.7);
    return kpssPuan;
  }

  double calculateDGSPuan() {
    double sayisalDogru = dogruSayilari[0];
    double sayisalYanlis = yanlisSayilari[0];
    double sozelDogru = dogruSayilari[1];
    double sozelYanlis = yanlisSayilari[1];

    double sayisalHamPuan = (sayisalDogru - sayisalYanlis * 0.25);
    double sozelHamPuan = (sozelDogru - sozelYanlis * 0.25);

    sayisalHamPuan = sayisalHamPuan > 100 ? 100 : sayisalHamPuan;
    sozelHamPuan = sozelHamPuan > 100 ? 100 : sozelHamPuan;

    double dgsPuan = (sayisalHamPuan * 0.5) + (sozelHamPuan * 0.5);
    return dgsPuan;
  }

  double calculateDUSPuan() {
    double temelBilimlerDogru = dogruSayilari[0];
    double temelBilimlerYanlis = yanlisSayilari[0];
    double klinikBilimlerDogru = dogruSayilari[1];
    double klinikBilimlerYanlis = yanlisSayilari[1];

    double temelBilimlerHamPuan =
        (temelBilimlerDogru - (temelBilimlerYanlis * 0.25));
    double klinikBilimlerHamPuan =
        (klinikBilimlerDogru - (klinikBilimlerYanlis * 0.25));

    temelBilimlerHamPuan =
        temelBilimlerHamPuan > 100 ? 100 : temelBilimlerHamPuan;
    klinikBilimlerHamPuan =
        klinikBilimlerHamPuan > 100 ? 100 : klinikBilimlerHamPuan;

    double dusPuan =
        (temelBilimlerHamPuan * 0.5) + (klinikBilimlerHamPuan * 0.5);
    return dusPuan;
  }

  double calculateEKPSSPuan() {
    double genelYetenekDogru = dogruSayilari[0];
    double genelYetenekYanlis = yanlisSayilari[0];
    double genelKulturDogru = dogruSayilari[1];
    double genelKulturYanlis = yanlisSayilari[1];

    double genelYetenekHamPuan =
        (genelYetenekDogru - genelYetenekYanlis * 0.25);
    double genelKulturHamPuan = (genelKulturDogru - genelKulturYanlis * 0.25);

    genelYetenekHamPuan = genelYetenekHamPuan > 100 ? 100 : genelYetenekHamPuan;
    genelKulturHamPuan = genelKulturHamPuan > 100 ? 100 : genelKulturHamPuan;

    double ekpssPuan = (genelYetenekHamPuan * 0.5) + (genelKulturHamPuan * 0.5);
    return ekpssPuan;
  }

  double calculateTUSPuan() {
    double temelTipDogru = dogruSayilari[0];
    double klinikTipDogru = dogruSayilari[1];

    double temelTipHamPuan = temelTipDogru * 1;
    double klinikTipHamPuan = klinikTipDogru * 1;

    temelTipHamPuan = temelTipHamPuan > 100 ? 100 : temelTipHamPuan;
    klinikTipHamPuan = klinikTipHamPuan > 100 ? 100 : klinikTipHamPuan;

    double tusPuan = (temelTipHamPuan * 0.5) + (klinikTipHamPuan * 0.5);
    return tusPuan;
  }

  double calculateYOKDILPuan() {
    double toplamDogru = 0;

    for (int i = 0; i < dersler.length; i++) {
      if (dersler[i] == 'Yabancı Dil') {
        toplamDogru += dogruSayilari[i];
      }
    }

    return toplamDogru * 1.25;
  }

  double calculateALESPuan() {
    double sozelDogru = dogruSayilari[0];
    double sozelYanlis = yanlisSayilari[0];
    double sayisalDogru = dogruSayilari[1];
    double sayisalYanlis = yanlisSayilari[1];

    double sozelHamPuan = (sozelDogru - sozelYanlis * 0.25);
    double sayisalHamPuan = (sayisalDogru - sayisalYanlis * 0.25);

    sozelHamPuan = sozelHamPuan > 100 ? 100 : sozelHamPuan;
    sayisalHamPuan = sayisalHamPuan > 100 ? 100 : sayisalHamPuan;
    double alesPuan = (sozelHamPuan * 0.5) + (sayisalHamPuan * 0.5);
    return alesPuan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sinavAdi + ' Puan Hesaplama'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < dersler.length; i++) ...[
                Card(
                  color: Color.fromARGB(255, 225, 232, 244),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dersler[i] + ' Bölümü',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Doğru Sayısı',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              dogruSayilari[i] = double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Yanlış Sayısı',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              yanlisSayilari[i] = double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Boş Sayısı',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              bosSayilari[i] = double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  if (widget.sinavAdi == 'TYT') {
                    puan = calculateTYTPuan();
                  } else if (widget.sinavAdi == 'AYT') {
                    puan = calculateAYTPuan();
                  } else if (widget.sinavAdi == 'YDS') {
                    puan = calculateYDSPuan();
                  } else if (widget.sinavAdi == 'KPSS') {
                    puan = calculateKPSSPuan();
                  } else if (widget.sinavAdi == 'DUS') {
                    puan = calculateDUSPuan();
                  } else if (widget.sinavAdi == 'DGS') {
                    puan = calculateDGSPuan();
                  } else if (widget.sinavAdi == 'EKPSS') {
                    puan = calculateEKPSSPuan();
                  } else if (widget.sinavAdi == 'TUS') {
                    puan = calculateTUSPuan();
                  } else if (widget.sinavAdi == 'YÖKDİL') {
                    puan = calculateYOKDILPuan();
                  } else if (widget.sinavAdi == 'ALES') {
                    puan = calculateALESPuan();
                  }
                  Fluttertoast.showToast(
                    msg: 'Toplam Puanınız: $puan',
                    backgroundColor: Colors.green,
                    timeInSecForIosWeb: 5,
                    fontSize: 22,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Puanı Hesapla',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
