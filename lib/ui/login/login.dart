import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: _screenSize.height,
              width: _screenSize.width,
              color: Colors.lightBlue,
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
            Positioned(
              height: _screenSize.height*0.60,
              top: _screenSize.height*0.40,
              child: Container(
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
                            child: buttonEmailAndPassword(),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:15),
                            child:     Text('Or',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(15),
                                child: facebookImage(),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                child: googleImage(),
                              )
                            ],
                            ),
                          )
                        ],
                      ),
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

  Widget buttonEmailAndPassword(){
    return ButtonTheme(
      minWidth: double.infinity,
      height: 40,
      child: RaisedButton(
          elevation: 2,
          color: Colors.redAccent ,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
        child: Text("Log In",style: TextStyle(color: Colors.white),),
        onPressed: (){}
      ),
    );
  }

  Widget facebookImage(){
    return GestureDetector(
      onTap: (){},
      child: Container(
        child: Image.asset(
          'assets/images/facebook.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Widget googleImage(){
    return GestureDetector(
      onTap: (){},
      child: Container(
        child: Image.asset(
          'assets/images/google.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }
  
}
