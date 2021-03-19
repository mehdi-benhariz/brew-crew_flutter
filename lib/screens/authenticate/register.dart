import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/widgets/signup.dart';
import 'package:brew_crew/widgets/textNew.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                    Row(children: <Widget>[SingUp(), TextNew()]),
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
                                  val.isEmpty ? "Enter an email" : null,
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
                                top: 40, left: 40, right: 40, bottom: 40),
                            child: TextFormField(
                              obscureText: true,
                              validator: (val) => val.length < 6
                                  ? "Enter a password longer than 6 caracter "
                                  : null,
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
                            height: 40,
                            width: 120,
                            child: new RaisedButton(
                              shape: StadiumBorder(),
                              onPressed: () async {
                                if (_formKey.currentState != null) {
                                  if (_formKey.currentState.validate()) {
                                    
                                    setState(() => loading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      print(result);
                                      setState(() =>
                                          {error = result, loading = false});
                                    }
                                  }
                                }
                              },
                              color: (password != "" && email != "")
                                  ? Colors.white
                                  : Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Sign Up',
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
                                    'Already have an Account ? ',
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
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
  }
}
