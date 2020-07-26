import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/products_insertion/add_product_widget/init_state_widget.dart';
import 'package:GroceryApp/products_insertion/add_product_widget/loadingIndicator.dart';
import 'package:GroceryApp/products_insertion/bloc/bloc.dart';
import 'package:GroceryApp/products_insertion/bloc/mang_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatelessWidget {
  final UserRepository userRepository;

  AddProductPage({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MangProductBloc>(
        create: (context) => MangProductBloc(userRepository: userRepository),
        child: 
        Scaffold(
            appBar: AppBar(title: Text("Hello world")),
            body: Container(
              child: ProductForm(userRepository),
            ),
          ));
  }
}

class ProductForm extends StatefulWidget {
  final UserRepository userRepository;

  ProductForm(this.userRepository);

  @override
  State<StatefulWidget> createState() {
    return ProductFormState();
  }
}

class ProductFormState extends State<ProductForm> {
  MangProductBloc mangProductBloc;
  UserRepository userRepository;

  @override
  void initState() {
    mangProductBloc = BlocProvider.of<MangProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MangProductBloc, MangProductState>(
        bloc: mangProductBloc,
        listener: (context, state) {
          String message = "Error Occured";
          Color col = Colors.red;
          if (state is SuccessAddProductState) {
            message = "SuccessFully Added";
            col = Colors.green;
          } else if (state is InitAddProductState) {
            message = "Ready to Add Product";
            col = Colors.lightGreenAccent;
          }
          else if (state is LoadingAddProductState) {
            message = "Adding to Database";
            col = Colors.blueAccent;
          }
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [Text(message), Icon(Icons.error)],
                ),
                backgroundColor: col,
              ),
            );
        },
        child: BlocBuilder<MangProductBloc, MangProductState>(
            builder: (context, state) {
          return findByState(state); 
        }));
  }

  Widget findByState(dynamic state) {
    if (state is InitAddProductState) {
      return InitStateWidget();
    }
    if (state is SuccessAddProductState) {
      return InitStateWidget();
    }
    if (state is LoadingAddProductState) {
      return LoadingIndicatorWidget();
    }
    return InitStateWidget();
  }
}
