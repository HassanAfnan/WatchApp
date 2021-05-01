import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:provider/provider.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {

    final state = Provider.of<AdminState>(context,listen: false);
    document = await PDFDocument.fromURL(state.rules_url);
    setState(() => _isLoading = false);
  }

  changePDF(value) async {

    final state = Provider.of<AdminState>(context,listen: false);
    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL(state.rules_url,

    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Giveaway Rules")),
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
