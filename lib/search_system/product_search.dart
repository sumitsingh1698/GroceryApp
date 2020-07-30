import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:GroceryApp/products_view/products_view_widgets/product_detail_page.dart';
import 'package:GroceryApp/search_system/model/algolia_key.dart';
import 'package:algolia/algolia.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class ProductSearch extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    AlgoliaQuery searchQuery;
    searchQuery = AlogliaKey.algolia.instance.index('products').search(query);

    return Column(
      children: <Widget>[
        FutureBuilder(
          future: searchQuery.getObjects(),
          builder: (BuildContext context,
              AsyncSnapshot<AlgoliaQuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading....');
                break;
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.hits.length,
                      itemBuilder: (context, index) {
                        final AlgoliaObjectSnapshot result =
                            snapshot.data.hits[index];
                        Product _product = Product(
                          productId: result.index,
                          name: result.data['name'],
                          cat: result.data['cat'],
                          oprice: result.data['oprice'],
                          scat: result.data['scat'],
                          pkt: result.data['pkt'],
                          discount: result.data['discount'],
                          qgiven: result.data['qgiven'],
                          quantity: result.data['quantity'],
                          imageurl: result.data['imageurl'],
                        );
                        double price = double.parse(result.data['oprice']);
                        double dis = double.parse(result.data['discount']);

                        // print(price);
                        price = price - (price * dis) / 100;
                        // print(price);
                        // return ListTile(
                        //   title: Text(result.data['name'],
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w700, fontSize: 18)),
                        //   subtitle: Text(result.data['oprice']),
                        // );

                        return Card(
                          elevation: 2.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                                product: _product,
                                              )));
                                },
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 90.0,
                                      width: 90.0,
                                      child: Image(
                                          image: FirebaseImage(
                                              '${_product.imageurl}')),
                                    ),
                                    SizedBox(width: 15.0),
                                    Container(
                                      width:
                                          orientation == Orientation.landscape
                                              ? 300
                                              : 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _product.name +
                                                " ( ${_product.qgiven} )",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                          _product.pkt + " pkt",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black54),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "₹${price.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 10.0,
                                              // ),
                                              // Container(
                                              //   child: Text(
                                              //     "₹${result.data['imageurl']}",
                                              //     style: TextStyle(
                                              //       decoration: TextDecoration
                                              //           .lineThrough,
                                              //       fontSize: 15.0,
                                              //       color: Colors.black54,
                                              //       fontWeight: FontWeight.bold,
                                              //     ),
                                              //     textAlign: TextAlign.left,
                                              //   ),
                                              // ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              OutlineButton(
                                textColor: Colors.blue,
                                child: MediaQuery.of(context).size.width *
                                            MediaQuery.of(context)
                                                .devicePixelRatio <
                                        500
                                    ? Icon(Icons.shopping_cart)
                                    : Container(child: Text('Add +')),
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                    width: 1),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
            }
          },
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    return Container();
  }
}
