import 'dart:async';


class LoginValidator{

  final validateEmailAddress = StreamTransformer<String, String>.fromHandlers(
      handleData: (emailAddress, sink) {
        emailAddress.isNotEmpty
            ? sink.add(emailAddress)
            : sink.addError('Type your email');
      });

  final validatePassWord = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        password.isNotEmpty
            ? sink.add(password)
            : sink.addError('Type your password');
      });
}