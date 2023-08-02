import 'package:flutter/material.dart';
import 'package:osym_sinav/puan_hesaplama.dart';

class HomePage extends StatelessWidget {
  final List<String> sinavlar = [
    //alfabetik sıraya göre
    'ALES',
    'AYT',
    'DGS',
    'DUS',
    'EKPSS',
    'KPSS',
    'TUS',
    'TYT',
    'YDS',
    'YÖKDİL'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ÖSYM Puan Hesaplayıcı',
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/sinavv.png', // Örnek olarak 'assets' klasörüne sınav simgesi ekleyin
                  width: 90,
                ),
                SizedBox(height: 32),
                Text(
                  'Sınavlara Hoş Geldiniz!',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Lütfen bir sınav seçin ve puanınızı hesaplayın.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: sinavlar.length,
                    itemBuilder: (context, index) {
                      final sinavAdi = sinavlar[index];
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SinavPuanHesaplamaScreen(sinavAdi),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            sinavAdi,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
