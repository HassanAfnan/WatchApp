import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:provider/provider.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {

    final state = Provider.of<AdminState>(context,listen: false);
    print(state.privacy_link);
    document = await PDFDocument.fromURL(state.privacy_link);
    setState(() => _isLoading = false);
  }

  changePDF(value) async {

    final state = Provider.of<AdminState>(context,listen: false);
    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL(state.privacy_link,

    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Privacy Policy")),
      body: Center(
          child: _isLoading
              ? Center(child:SpinKitRipple(color: Colors.deepPurpleAccent,))
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                )),
    );
  }
}
