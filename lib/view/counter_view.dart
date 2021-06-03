import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/box_manager.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  /// [3] Öncesinde açtığımız kutuyu çağırmak için oluşturduğumuz değişken
  late Box<int> _boxCounter;

  /// [4] Değişimini izleyeceğimiz sayaç değişkeni
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    /// [5] Açılan Kutuyu [ÇAĞIR]
    _boxCounter = Hive.box<int>(BoxManager.instance.boxNameCounter);
  }

  @override
  void dispose() {
    /// [6] İşi biten Kutuyu [KAPAT]
    /// 1. Alternatif:
    /// Sadece [_boxCounter] isimli kutuyu kapatır
    _boxCounter.close();

    /// 2. Alternatif:
    /// Tüm Kutuluarı kapatır
    /// Hive.close();
    super.dispose();
  }

  /// [7] Metotları Oluştur
  /// [7-A] Arttırma Metodu
  void incrementCounter() {
    /// Write Box - Kutuya [YAZ/KAYDET]
    /// Counter değerini bir arttır.
    _boxCounter.put(BoxManager.instance.keyNameCounter, (_counter++) + 1);
  }

  /// [7-B] Sıfırlama Metodu
  void resetCounter() {
    /// Write Box - Kutuya [YAZ/KAYDET]
    /// Counter değerini sıfıra eşitle.
    _boxCounter.put(BoxManager.instance.keyNameCounter, _counter = 0);
  }

  /// [7-C] Azaltma Metodu
  void decrementCounter() {
    /// Write Box - Kutuya [YAZ/KAYDET]
    /// Counter değerini bir azalt.
    _boxCounter.put(BoxManager.instance.keyNameCounter, (_counter--) - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter App Hive DB',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sayaç Değeri:',
              style: Theme.of(context).textTheme.headline3,
            ),

            /// [8] Kutuyu [DİNLE]
            ValueListenableBuilder<Box<int>>(
              /// [8-A] [valueListenable] parametresine
              /// Açtığımız/Çağırdığımız kutuyu dinlemesini istedik.
              valueListenable: _boxCounter.listenable(),
              builder: (context, box, widget) {
                /// Read Box - Kutudan [OKU/GETİR]
                /// [8-B] Dinlediğimiz kutudaki değişkenin değerine eriştik.
                /// [defaultValue] Varsayılan değeri 0 atadık.
                /// Yani başlarken kutuda değer olmayacağı için 0 gelsin.
                var readCounter = box.get(BoxManager.instance.keyNameCounter, defaultValue: 0);
                return Text(
                  /// [8-C] Ekrana yazdıralım
                  '$readCounter',
                  style: Theme.of(context).textTheme.headline3,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),

            /// [9]: Arttır FAB Düğmesi
            child: FloatingActionButton(
              heroTag: 'incrementTag',
              onPressed: incrementCounter,
              tooltip: 'Arttır',
              child: Icon(
                Icons.add,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),

            /// [10]: Sıfırla FAB Düğmesi
            child: FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              heroTag: 'resetTag',
              onPressed: resetCounter,
              tooltip: 'Sıfırla',
              child: Icon(
                Icons.exposure_zero_sharp,
              ),
            ),
          ),

          /// [11]: Azalt FAB Düğmesi
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: FloatingActionButton(
              heroTag: 'decrementTag',
              onPressed: decrementCounter,
              tooltip: 'Azalt',
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
