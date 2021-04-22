import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/watch/spash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

import 'package:stripe_payment/stripe_payment.dart' as strip;
class StripePayment extends StatefulWidget {
  final String cost;
  StripePayment({Key key,this.cost}) : super(key: key);


  @override
  _StripePaymentState createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {

  final String postCreateIntentURL = "https:/yourserver/postPaymentIntent";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StripeCard card = StripeCard();

  // final Stripe stripe = Stripe(
  //   "pk_test_51IhtZHLwf8p7hancgtg4O1ycYT3dpe9rWgkwE9GG5cUA60CPmSwzVmwjXWin2F6BUeM5p4QV9Hm17fBDHm3YNgFI00b8AhfYpN", //Your Publishable Key
  //   stripeAccount: "acct_1G...", //Merchant Connected Account ID. It is the same ID set on server-side.
  //   returnUrlForSca: "stripesdk://3ds.stripesdk.io", //Return URL for SCA
  // );
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   strip.StripePayment.setOptions(
        strip.StripeOptions(publishableKey: "pk_test_51IhtZHLwf8p7hancgtg4O1ycYT3dpe9rWgkwE9GG5cUA60CPmSwzVmwjXWin2F6BUeM5p4QV9Hm17fBDHm3YNgFI00b8AhfYpN"));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Payment"),
      ),
      body: new SingleChildScrollView(
        child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: Column(
              children: [
                CardForm(
                    formKey: formKey,
                    card: card
                ),
                Container(
                  child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: const Text('Buy', style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        formKey.currentState.validate();
                        formKey.currentState.save();
                        sendPayment();
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void buy(context) async{
  //   final StripeCard stripeCard = card;
  //   final String customerEmail = getCustomerEmail();
  //
  //   if(!stripeCard.validateCVC()){showAlertDialog(context, "Error", "CVC not valid."); return;}
  //   if(!stripeCard.validateDate()){showAlertDialog(context, "Errore", "Date not valid."); return;}
  //   if(!stripeCard.validateNumber()){showAlertDialog(context, "Error", "Number not valid."); return;}
  //
  //   Map<String, dynamic> paymentIntentRes = await createPaymentIntent(stripeCard, customerEmail);
  //   String clientSecret = paymentIntentRes['client_secret'];
  //   String paymentMethodId = paymentIntentRes['payment_method'];
  //   String status = paymentIntentRes['status'];
  //
  //   if(status == 'requires_action') //3D secure is enable in this card
  //     paymentIntentRes = await confirmPayment3DSecure(clientSecret, paymentMethodId);
  //
  //   if(paymentIntentRes['status'] != 'succeeded'){
  //     showAlertDialog(context, "Warning", "Canceled Transaction.");
  //     return;
  //   }
  //
  //   if(paymentIntentRes['status'] == 'succeeded'){
  //     showAlertDialog(context, "Success", "Thanks for buying!");
  //
  //     return;
  //   }
  //   showAlertDialog(context, "Warning", "Transaction rejected.\nSomething went wrong");
  // }
  //
  // Future<Map<String, dynamic>> createPaymentIntent(StripeCard stripeCard, String customerEmail) async{
  //   String clientSecret;
  //   Map<String, dynamic> paymentIntentRes, paymentMethod;
  //   try{
  //     paymentMethod = await stripe.api.createPaymentMethodFromCard(stripeCard);
  //     clientSecret = await postCreatePaymentIntent(customerEmail, paymentMethod['id']);
  //     paymentIntentRes = await stripe.api.retrievePaymentIntent(clientSecret);
  //   }catch(e){
  //     print("ERROR_CreatePaymentIntentAndSubmit: $e");
  //     showAlertDialog(context, "Error", "Something went wrong.");
  //   }
  //   return paymentIntentRes;
  // }
  //
  // Future<String> postCreatePaymentIntent(String email, String paymentMethodId) async{
  //   String clientSecret;
  //   http.Response response = await http.post(
  //     postCreateIntentURL,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': email,
  //       'payment_method_id' : paymentMethodId,
  //     }),
  //   );
  //   clientSecret = json.decode(response.body);
  //   return clientSecret;
  // }
  //
  // Future<Map<String, dynamic>> confirmPayment3DSecure(String clientSecret, String paymentMethodId) async{
  //   Map<String, dynamic> paymentIntentRes_3dSecure;
  //   try{
  //     await stripe.confirmPayment(clientSecret, paymentMethodId: paymentMethodId);
  //     paymentIntentRes_3dSecure = await stripe.api.retrievePaymentIntent(clientSecret);
  //   }catch(e){
  //     print("ERROR_ConfirmPayment3DSecure: $e");
  //     showAlertDialog(context, "Error", "Something went wrong.");
  //   }
  //   return paymentIntentRes_3dSecure;
  // }
  //
  //
  // String getCustomerEmail(){
  //   String customerEmail;
  //   //Define how to get this info.
  //   // -Ask to the customer through a textfield.
  //   // -Get it from firebase Account.
  //   customerEmail = "alessandro.berti@me.it";
  //   return customerEmail;
  // }

  showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(), // dismiss dialog
            ),
          ],
        );
      },
    );
  }
  void sendPayment() {
    final StripeCard stripeCard = card;

    if (!stripeCard.validateCVC()) {
      showAlertDialog(context, "Error", "CVC not valid.");
      return;
    }
    if (!stripeCard.validateDate()) {
      showAlertDialog(context, "Errore", "Date not valid.");
      return;
    }
    if (!stripeCard.validateNumber()) {
      showAlertDialog(context, "Error", "Number not valid.");
      return;
    }
    final strip.CreditCard testCard1 = strip.CreditCard(
        number: card.number,
        expMonth: card.expMonth,
        expYear: card.expYear,
        cvc: card.cvc
    );
    strip.StripePayment.createTokenWithCard(
      testCard1,
    ).then((token) {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text("Watch"),
                content: Text("Payment Confirmed"),
              )
      );
      //  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Payment Confirmed')));
      setState(() async {
        // _paymentToken = token;
        // print("token");
        // print(token.toJson());
        // print(token.tokenId);
        // print(widget.amount);

        Map<String, String> headers = {"Content-type": "application/json"};
//                    String json='{ "stripeToken": token.tokenId,
//                        "name":'talha',
//                        "email":'talha@gmail.com',
//                        "total_price": 77
//                    }';

        String m = token.tokenId.toString();
        String json = '{"stripeToken":"' + m +
            '","name":"talha","email":"talha@gmail.com","total_price": "'+
            widget.cost + '"}';
        if (token != null) {
          http.Response response = await http.post(
              "https://calm-hollows-88609.herokuapp.com/donate", body: (json),
              headers: headers);
          // check the status code for the result
          int statusCode = response.statusCode;
          print(statusCode);
          print(response.body);
          if (statusCode == 200) {
            print(response.body);

            var authState = Provider.of<AuthState>(context, listen: false);
            UserModel user=authState.userModel;
            user.isSubscribed=true;
            user.subscribeDate=DateTime.now().toString();
            authState.updateUserProfile(user);
            //firebase code and dialog box here
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text("WatchApp"),
                      content: Text("Payment Confirmed"),
                    )
            );
            // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Payment Confirmed of '+widget.amount)));

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    WatchSplashScreen()), (Route<dynamic> route) => false);
          }
        }
        //   print(_paymentMethod.card.token);
//                    final request = await http.post(
//                      "https://pam-app.herokuapp.com/",
//                      body: {
//                        "stripeToken": token.tokenId,
//                        "name":'talha',
//                        "email":'talha@gmail.com',
//                        "total_price": 77
//                      },
//                      headers: <String, String>{
//                        'Content-Type': 'application/json; charset=UTF-8',
//                     },
//                    );
//                    if (request.statusCode == 200) {
//                      print(request.body);
//                      print("hussain");
//                      return true;
//                    } else {
//
//                      print(jsonDecode(request.body));
//                      return false;
//                    }

      });
    }).catchError(setError);
  }

  void setError(dynamic error) {
    print(error);
  }
}
