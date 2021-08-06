import 'package:audiopdf/services/auth.dart';
import 'package:audiopdf/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // textField state
  String email = " ";
  String password = " ";
  String error = " ";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[500],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children:<Widget> [
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                  child: Text(
                    "Welcome,",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 76.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 140.0, 0.0, 0.0),
                  child: Text(
                    "To Audiopdf",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(24.0, 207.0, 0.0, 0.0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null ,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.orange[800],
                        filled: true,
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[800], width: 2.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[800],width:  2.0)
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                    onChanged:(val){
                      setState(() => password = val);
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.orange[800],
                        filled: true,
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[800], width: 2.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[800],width:  2.0)
                        )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 45.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      shadowColor: Colors.deepPurple[800],
                      color: Colors.deepPurple[900],
                      elevation: 7.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true );
                            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                            if(result == null){
                              setState(() {
                                error = "Could not sign in with those credentials";
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "OpenSans"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "New to Audiopdf ?",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                    fontSize: 18.0,
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                  onTap: () {
                    widget.toggleView();
                  },
                  child: Text("Register",
                      style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          decoration: TextDecoration.underline
                      )
                  )
              )
            ],
          ),
          SizedBox(height: 5.0),
          Container(
              padding: EdgeInsets.fromLTRB(105.0, 30.0, 0.0, 0.0),
              child: Text(
                'By continuing, you agree to accept our \nPrivacy Policy & Terms of Service.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                  height: 1.5,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              )
          ),
          SizedBox(height: 12),
          Container(
              padding: EdgeInsets.fromLTRB(110.0, 20.0, 0.0, 0.0),
              child: Text(
                error,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.deepPurple,
                  height: 1.5,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              )
          ),
        ],
      ),
    );
  }
}
