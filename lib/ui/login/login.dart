import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/login_bloc/login_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: _screenSize.height * 0.40,
              width: _screenSize.width,
              color: Colors.lightBlue,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 35, bottom: 10),
                      child: Image.asset(
                        'assets/images/pokeball.png',
                        width: 85,
                        height: 85,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "PokeFlutter",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                    child: Text(
                      "Search all the pokemons in every region and create your pokemon teams and share your teams with your friends.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: _screenSize.height * 0.60),
              child: Container(
                width: _screenSize.width,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0)),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Log in and start to capture!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'Log in with your Email and Password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: emailField(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: passField(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: buttonEmailAndPassword(),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            'Or',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5, right: 8),
                              child: facebookImage(),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 8),
                              child: googleImage(),
                            )
                          ],
                        ),
                      ),
                      registerUser()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder<String>(
        stream: loginBLoc.getEmailAddress,
        builder: (context, snapshot) {
          return TextField(
            decoration:
                InputDecoration(labelText: 'Email', errorText: snapshot.error),
            keyboardType: TextInputType.text,
            onChanged: loginBLoc.changeEmail,
          );
        });
  }

  Widget passField() {
    return StreamBuilder<String>(
        stream: loginBLoc.getPassword,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password', errorText: snapshot.error),
            keyboardType: TextInputType.text,
            onChanged: loginBLoc.changePassword,
          );
        });
  }

  Widget buttonEmailAndPassword() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 40,
      child: StreamBuilder<bool>(
          stream: loginBLoc.canLogin,
          builder: (context, snapshot) {
            return RaisedButton(
                elevation: 2,
                color: Colors.redAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: snapshot.hasData ? () {} : null);
          }),
    );
  }

  Widget facebookImage() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Image.asset(
          'assets/images/facebook.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Widget googleImage() {
    return GestureDetector(
      child: Container(
        child: Image.asset(
          'assets/images/google.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Widget registerUser() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 20),
        child: Text(
          "Don't have a account?",
          style: TextStyle(color: Colors.black26),
        ),
      ),
      FlatButton(
          child: Text(
            "Register now",
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {})
    ]);
  }
}
