import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/userdetail/bloc/user_bloc.dart';
import 'package:GroceryApp/userdetail/bloc/user_detail_bloc.dart';
import 'package:GroceryApp/userdetail/set_detail_widgets/address_form.dart';
import 'package:GroceryApp/userdetail/set_detail_widgets/details_inputs.dart';
import 'package:GroceryApp/userdetail/set_detail_widgets/loading_indicator.dart';
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
  @override
  void initState() {
    _userDetailBloc = BlocProvider.of<UserDetailBloc>(context);
    super.initState();
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
                    child: Center(child: FaIcon(FontAwesomeIcons.gamepad),),
                
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: getViewAsPerState(state)),
                      flex: 1)
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
    } else {
      // return NumberInput();
    }
  }
}
