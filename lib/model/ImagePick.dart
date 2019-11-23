import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Capture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageUpload(),
    );
  }
}

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File _image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _image.path,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xFFf3f6fb),
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false));

    setState(() {
      _image = cropped ?? _image;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected =
    await ImagePicker.pickImage(source: source, imageQuality: 50);

    setState(() {
      _image = selected;
    });
  }

  void _clear() {
    setState(() {
      _image = null;
    });
  }

  Future<void> _upload(BuildContext context) async {
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();
    var uri = Uri.parse("https://uitonlinereg.000webhostapp.com/file-upload.php");

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(_image.path));
    request.files.add(multipartFile);

    print(request);

    var response = await request.send();

    if (response.statusCode == 200) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Text('Image Uploaded',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF2d3447),
          duration: Duration(seconds: 2)));
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Your Image')),
      endDrawer: new Drawer(
          child: new Column(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("",
                      style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0)
                  ),
                  accountEmail: new Text("firstname@lastname.com",
                      style: new TextStyle(color: Colors.blueGrey[50])
                  ),
                  currentAccountPicture: new CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: new Text("FL")
                  ),
                ),
                new ListTile(
                  leading: Icon(Icons.account_circle),
                  title: new Text('My Profile'),
                  onTap: () {
                    this.setState(() {
                      var screen = 1;
                    });
                    Navigator.pop(context);
                  },
                ),

                new ListTile(
                  leading: Icon(Icons.error_outline),
                  title: new Text('Terms & Regulations'),
                  onTap: () {
                    this.setState(() {});
                    Navigator.pop(context);
                  },
                ),
                new Divider(),
                new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text('Logout'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
                  },
                ),
              ])),
      key: _scaffoldKey,
      backgroundColor: Color(0xFFf3f6fb),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_image != null) ...[
            Image.file(_image),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
                FlatButton(
                  child: Icon(Icons.file_upload),
                  onPressed: () => _upload(context),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}