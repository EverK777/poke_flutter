import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              height: _screenSize.height*0.40,
              width: _screenSize.width,
              padding: EdgeInsets.only(top: 45),
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
            Container(
                child: Container(
                  height: _screenSize.height*0.60,
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
                              color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Log in with your Email and Password',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.normal,fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: emailField(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: passField(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:15),
                          child:     Text('Or',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      )
    );
  }

  Widget emailField(){
    return TextField(
        decoration: InputDecoration(labelText: 'Email'),
        keyboardType: TextInputType.text);
  }
  Widget passField(){
    return TextField(
      obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
        keyboardType: TextInputType.text);
  }
  
}
