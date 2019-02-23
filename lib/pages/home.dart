import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title);

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var _code = TextEditingController();
  var _codeData = 'http://www.citcoms.up.ac.th';
  var _scanResult = 'no scan data';

  Widget _qrCodePage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            decoration: InputDecoration(hintText: 'code data'),
            controller: _code,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OutlineButton(
            child: Text('Show QR Code'),
            onPressed: () {
              setState(() {
                _codeData = _code.text;
              });
            },
          ),
        ),
        QrImage(
          version: 2,
          data: _codeData,
          size: 200.0,
        )
      ],
    );
  }

  Widget _scanPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OutlineButton(
            child: Text('Scan Now'),
            onPressed: () {
              BarcodeScanner.scan().then((result) {
                setState(() {
                  _scanResult = result;
                });
              });
            },
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Center(
          child: Text(_scanResult),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'QR Code',
                icon: Icon(Icons.code),
              ),
              Tab(text: 'Scan', icon: Icon(Icons.camera_alt)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _qrCodePage(),
            _scanPage(),
          ],
        ),
      ),
    );
  }
}
