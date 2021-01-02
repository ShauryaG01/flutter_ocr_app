import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:intl/intl.dart';


class TextListScreen extends StatefulWidget {
  @override
  _TextListScreenState createState() => _TextListScreenState();
}

class _TextListScreenState extends State<TextListScreen> {
  final _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  List<String> _textValue = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _textValue = [];
              });
            },
          ),
        ],
      ),
      body: _textValue.isEmpty
          ? Center(
              child: Text('Start Searching'),
            )
          : ListView.builder(
              itemCount: _textValue.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(_textValue[i]),
                subtitle: Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onTap: () {},
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _read,
        child: Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue.insert(0, texts[0].value);
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}
