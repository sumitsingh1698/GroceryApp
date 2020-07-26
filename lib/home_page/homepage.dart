import 'package:GroceryApp/cart/cart_floatingButton.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/home_page/bloc/homepage_state.dart';
import 'package:GroceryApp/home_page/bloc/hompage_bloc.dart';
import 'package:GroceryApp/home_page/bloc/hompage_event.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_drawer.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_silverappbar.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_subcat.dart';
import 'package:GroceryApp/home_page/homepage_widgets/homepage_third_section.dart';
import 'package:GroceryApp/products_view/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageParent extends StatelessWidget {
  final UserRepository _userRepository;
  final List list = ['12', '11'];

  HomepageParent(this._userRepository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageBloc(userRepository: _userRepository),
      child: Scaffold(
        drawer: HomePage_Drawer(_userRepository),
        floatingActionButton: CartFloatingButton(_userRepository.userDetail),
        body: HomePage(_userRepository),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final UserRepository userRepository;
  HomePage(this.userRepository);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  String name = 'My Wishlist';
  HomepageBloc _homepageBloc;

  @override
  void initState() {
    _homepageBloc = BlocProvider.of<HomepageBloc>(context);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomepageBloc, HomepageState>(
      listener: (context, state) {
        if (state is HomepageExceptionState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [Text("Error Occured"), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      bloc: _homepageBloc,
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is InitHomepageState) {
            return CustomScrollView(
              slivers: <Widget>[
                HomePageSilverAppBar(),
                //   SliverFixedExtentList(
                //     itemExtent: 60.0,
                //     delegate: SliverChildListDelegate(
                //       [
                //         HomePageFirstSection(),
                //       ],
                //     ),
                //   ),
                //  SliverToBoxAdapter(
                //    child: HomePageSecondSection(),
                //  ),
                SliverFixedExtentList(
                  itemExtent: 40.0,
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Categories",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left),
                            ],
                          )),
                    ],
                  ),
                ),
                HomePageThirdSection(),
                 SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height:20.0)
                    ]
                  ),) 

              ],
            );
          } else if (state is HomepageProductListState) {
            return ProductView(
              products: state.products,
              userRepository: widget.userRepository,
            );
          } else if (state is SubcatState) {
            return CustomScrollView(
              slivers: <Widget>[
                HomePageSilverAppBar(),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                          padding: EdgeInsets.only(top: 10.0, left: 0.0),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    BlocProvider.of<HomepageBloc>(context)
                                        .add(InitStartEvent());
                                  })
                            ],
                          )),
                    ],
                  ),
                ),
                HomePageSubcatSection(
                  subcats: state.subcat,
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height:20.0)
                    ]
                  ),)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Icon keyloch = new Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );
}
