import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
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
              child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit, feugiat dictumst porttitor taciti potenti aenean. Consequat morbi luctus pharetra gravida netus ultricies viverra aliquam, sociis tempus vivamus montes porttitor iaculis urna himenaeos, suspendisse ullamcorper accumsan maecenas lobortis mus sagittis. Vulputate himenaeos aptent pharetra augue blandit eros vitae, arcu orci a dignissim sociosqu nullam, donec natoque est mi ullamcorper consequat.Non consequat arcu rhoncus posuere nullam blandit id sociis, penatibus commodo quis nulla imperdiet tellus platea, augue sodales placerat quisque risus iaculis in. Eget quam tempus interdum lacinia accumsan hendrerit fermentum, mus varius molestie erat sociis bibendum netus magnis, nostra massa est cum justo dignissim. Ligula torquent scelerisque etiam habitasse aptent neque, lobortis nisl eget parturient semper conubia, felis primis vehicula netus egestas.Lorem ipsum dolor sit amet consectetur adipiscing elit, feugiat dictumst porttitor taciti potenti aenean. Consequat morbi luctus pharetra gravida netus ultricies viverra aliquam, sociis tempus vivamus montes porttitor iaculis urna himenaeos, suspendisse ullamcorper accumsan maecenas lobortis mus sagittis. Vulputate himenaeos aptent pharetra augue blandit eros vitae, arcu orci a dignissim sociosqu nullam, donec natoque est mi ullamcorper consequat.",
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
