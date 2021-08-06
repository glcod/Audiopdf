import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:file_picker/file_picker.dart';

class Home extends StatelessWidget {
  PDFDoc doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Audiopdf"),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[700],
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () => print("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Quit"),
              onTap: () => SystemNavigator.pop(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _pickPDFText,
        backgroundColor: Colors.deepPurple[700],
      ),
    );
  }

  Future _pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      doc = await PDFDoc.fromPath(filePickerResult.files.single.path);
    }
  }
}
