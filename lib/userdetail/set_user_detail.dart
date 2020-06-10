import 'dart:async';

import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/splash/internet_not_connect_page.dart';
import 'package:GroceryApp/userdetail/bloc/user_bloc.dart';
import 'package:GroceryApp/userdetail/bloc/user_detail_bloc.dart';
import 'package:GroceryApp/userdetail/set_detail_widgets/address_form.dart';
import 'package:GroceryApp/userdetail/set_detail_widgets/details_inputs.dart';
import 'package:GroceryApp/userdetail/set_detail_widgets/loading_indicator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDetails extends StatelessWidget {
  final UserRepository userRepository;

  UserDetails({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailBloc>(
      create: (context) => UserDetailBloc(userRepository: userRepository),
      child: Scaffold(
        body: UserDetailForm(),
      ),
    );
  }
}

class UserDetailForm extends StatefulWidget {
  @override
  _UserDetailFormState createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  UserDetailBloc _userDetailBloc;
   StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    _userDetailBloc = BlocProvider.of<UserDetailBloc>(context);
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
        BlocProvider.of<UserDetailBloc>(context).add(CheckInternet());
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailBloc, UserDetailState>(
      bloc: _userDetailBloc,
      listener: (context, userDetailState) {
        if (userDetailState is ExceptionState) {
          String message = userDetailState.message;

          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [Text(message), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<UserDetailBloc, UserDetailState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(

                      width: double.infinity,
                      height: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.fill,),
                        SizedBox(width: 10,),
                         Text("Submit",style: TextStyle(fontSize:35,fontWeight: FontWeight.bold),),
                         SizedBox(width:20),
                        FaIcon(FontAwesomeIcons.info,size:40),
                        Text("nfo ",style: TextStyle(fontSize:34,fontWeight: FontWeight.bold),),
                      ],
                    ),),
                
                    ),
                  ),
                  Expanded(
                      child: Center(
                        child: getViewAsPerState(state),
                      ),
                      flex: 2)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  getViewAsPerState(UserDetailState state) {
    if (state is InitialUserDetailState) {
      return DetailsInputs();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else if (state is UpdateAddressState) {
      return AddressFrom();
    } else if (state is SuccessSubmitedState) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
    }else if(state is InternetNotConnectState){
      return NoInternet(onclick: (){
       BlocProvider.of<UserDetailBloc>(context).add(CheckInternet());
      }, fontsize: 15);
    } else {
       return DetailsInputs();
    }
  }
}
