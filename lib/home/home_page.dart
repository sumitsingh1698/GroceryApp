import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

   UserRepository _userRepository;

  HomePage(this._userRepository);

  @override
  Widget build(BuildContext context) {
   String uid;
    
   _userRepository.getUser().then((value) {
    
     uid = value.uid;
    print(uid);
     });

    return Scaffold(
         appBar: AppBar(title: Text("HomePage"),),
          body: Container(
        child: Column(
          children: <Widget>[
            Text("${_userRepository.userDetail.getEmail}"),
              Text("${_userRepository.userDetail.getCart.length}"),
            RaisedButton(onPressed: (){
             BlocProvider.of<AuthenticationBloc>(context)
                .add(LoggedOut());
            }),
          ],
        ),
      ),
    );
  }
}
