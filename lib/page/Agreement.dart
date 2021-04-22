import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAgreement extends StatefulWidget {
  final UserModel user;
  final String password;

  const CreateAgreement({Key key, this.user, this.password}) : super(key: key);

  @override
  _CreateAgreementState createState() => _CreateAgreementState();
}

class _CreateAgreementState extends State<CreateAgreement>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();

  CustomLoader loader;

  TabController _tabController;
  bool _isLoading = true;
  PDFDocument document, document1, document2;

  @override
  void initState() {
    loader = CustomLoader();

    _tabController = new TabController(length: 1, vsync: this);

    //  _tabController.addListener(_handleTabSelection);
    super.initState();

    loadDocument();
  }


  loadDocument() async {


    document = await PDFDocument.fromURL("https://firebasestorage.googleapis.com/v0/b/watch-5a142.appspot.com/o/admin%2Fsetting%2FCompetition-Giveaway%20Rules.pdf?alt=media&token=309e3466-f5ce-4d53-87da-dbeedc32fbbb");
    setState(() => _isLoading = false);
  }

  changePDF(value) async {

    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL("https://firebasestorage.googleapis.com/v0/b/watch-5a142.appspot.com/o/admin%2Fsetting%2FCompetition-Giveaway%20Rules.pdf?alt=media&token=309e3466-f5ce-4d53-87da-dbeedc32fbbb");

    setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(""),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          tabs: [
            new Tab(
              icon: new Icon(Icons.security),
              text: "Official Giveaway Rules",
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        actions: [
          new FlatButton(
              onPressed: () async {
                registerUser(widget.user, widget.password);
              },
              child: new Text('AGREE',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
        bottomOpacity: 1,
      ),
      body: TabBarView(
        key: _scaffoldKey1,
        children: [
          _isLoading
              ? new Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ))
              : new PDFViewer(
                  document: document,
                  zoomSteps: 2,
                ),
        ],
        controller: _tabController,
      ),
    );
  }


  void registerUser(UserModel user, String password) {
    var state = Provider.of<AuthState>(context, listen: false);
    loader.showLoader(context);
    state
        .signUp(
      user,
      password: password,
      scaffoldKey: _scaffoldKey,
    )
        .then((status) {
      print(status);
    }).whenComplete(
      () {
        loader.hideLoader();
        if (state.authStatus == AuthStatus.LOGGED_IN) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);

          // widget.loginCallback();
        }
      },
    );
  }
}
