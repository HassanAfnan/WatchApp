import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/paymentgateway/PaypalPayment.dart';
import 'package:flutter_twitter_clone/paymentgateway/StripePayment.dart';

class makePayment extends StatefulWidget {
final String cost;

  const makePayment({Key key, this.cost}) : super(key: key);
  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {

  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


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

              ],
            ),
          )
      ),
    );
  }

}