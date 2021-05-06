import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/paymentgateway/PaypalPayment.dart';
import 'package:flutter_twitter_clone/paymentgateway/StripePayment.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:provider/provider.dart';
//
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';


class makePayment extends StatefulWidget {
final String cost;

  const makePayment({Key key, this.cost}) : super(key: key);
  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {

  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //
  // void _pay() {
  //   InAppPayments.setSquareApplicationId('sandbox-sq0idb-4ZN_l6tHN5JxUx8Epf6pEg');
  //   InAppPayments.startCardEntryFlow(
  //     onCardEntryCancel: _cardEntryCancel,
  //     onCardNonceRequestSuccess: _cardNonceRequestSuccess,
  //   );
  // }

  void _cardEntryCancel() {
    // Cancel
  }
  //
  // void _cardNonceRequestSuccess(CardDetails result) {
  //   // Use this nonce from your backend to pay via Square API
  //   print(result.nonce);
  //
  //   final bool _invalidZipCode = false;
  //
  //   if (_invalidZipCode) {
  //     // Stay in the card flow and show an error:
  //     InAppPayments.showCardNonceProcessingError('Invalid ZipCode');
  //   }
  //
  //   InAppPayments.completeCardEntry(
  //     onCardEntryComplete: _cardEntryComplete,
  //   );
  // }

  void _cardEntryComplete() {
    var authState = Provider.of<AuthState>(context, listen: false);

    // Success
    //_resetCounter();
    UserModel user=authState.userModel;
    user.isSubscribed=true;
    user.subscribeDate=DateTime.now().toString();
    authState.updateUserProfile(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: primary,
        title: Text(
          'Make Payments',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Open Sans'),
        ),
      ),
      body:Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Please subscribe to Elite Edgeware and be entered into our monthly draw and have full use of the services in \njust £11.99",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign: TextAlign.center,),
                SizedBox(height: 100,),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  onPressed: (){

                    // make PayPal payment

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                          cost: widget.cost,
                          onFinish: (number) async {

                            // payment done
                            print('order id: '+number);

                          },
                        ),
                      ),
                    );


                  },
                  child: Image.asset("assets/paypal.png",height: 80,width: 100,),
                  //child: Text('Pay with Paypal', textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  onPressed: (){

                    // make PayPal payment

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => StripePayment(
                          cost: widget.cost,
                        ),
                      ),
                    );


                  },
                  child:  Image.asset("assets/stripe.png",height: 80,width: 100,),
                  //child: Text('Pay with Stripe', textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20,),
                // Platform.isIOS ? Text("OR"): SizedBox(),
                // Platform.isIOS ?  RaisedButton(
                //    onPressed: _pay,
                //    child: Text("In App Payment"),
                //  ): SizedBox()

              ],
            ),
          )
      ),
    );
  }

}