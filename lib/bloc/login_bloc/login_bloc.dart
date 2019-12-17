
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/login_bloc/login_validator.dart';
import 'package:poke_flutter/data/firebase_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with LoginValidator implements BlocBase{

  BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>();



  //Add data to stream
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  // streams
  Stream<String> get getEmailAddress => _emailController.stream.transform(validateEmailAddress);
  Stream<String> get getPassword => _passwordController.stream.transform(validatePassWord);
  Stream<bool> get canLogin => Observable.combineLatest2(getEmailAddress, getPassword,
          (email,password)=>true);



  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
final loginBLoc = LoginBloc();
