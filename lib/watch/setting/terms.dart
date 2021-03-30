import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:provider/provider.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {

    final state = Provider.of<AdminState>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Terms And Conditions")
      ),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          WidgetAnimator(
             Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Text(state.terms_and_conditions,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }
}
