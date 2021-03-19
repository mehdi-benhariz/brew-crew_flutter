import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/widgets/textLogin.dart';
import 'package:brew_crew/widgets/verticalText.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";

  bool validateEmail(val) {
    return (val.isEmpty || !val.contains("@") || !val.contains("."));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blueGrey, Colors.lightBlueAccent]),
            ),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      VerticalText(),
                      TextLogin(),
                    ]),
                    RaisedButton(
                      child: Text('sign in anon'),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          setState(() =>
                              {loading = false, error = "error signing in"});
                        } else {
                          print('signed in');
                          print(result.uid);
                        }
                      },
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 40, right: 40),
                            child: TextFormField(
                              validator: (val) =>
                                  validateEmail(val) ? "Enter an email" : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Email"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 40, right: 40, bottom: 30),
                            child: TextFormField(
                              validator: (val) => val.length < 6
                                  ? "Enter a password longer than 6 caracter "
                                  : null,
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Password"),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 120,
                            child: FlatButton(
                              shape: StadiumBorder(),
                              color: (email != "" && password != "")
                                  ? Colors.white
                                  : Colors.transparent,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  print("valid");
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    print(result);
                                    setState(() => {
                                      loading = false, error = "error signing in"});
                                  } else {}
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 240,
                            height: 40,
                            child: new RaisedButton(
                              shape: StadiumBorder(),
                              onPressed: widget.toggleView,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Don\'t have an Account ? ',
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.person,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,)
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                )
              ],
            ),
          ));
  }
}
