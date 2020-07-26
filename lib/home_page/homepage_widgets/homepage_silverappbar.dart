import 'package:GroceryApp/home_page/homepage_widgets/sabt.dart';
import 'package:GroceryApp/search_system/product_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageSilverAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      onStretchTrigger: () {
        print("hel");
        return;
      },
      expandedHeight: 190,
      title: SABT(
          child: Container(
        height: 36.0,
        width: double.infinity,
        child: CupertinoTextField(
          
          onTap: () {
            showSearch(context: context, delegate: ProductSearch());
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search any product',
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
            child: Icon(
              Icons.search,
              color: Color(0xffC4C6CC),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(0xffF0F1F5),
          ),
        ),
      )),
      actions: <Widget>[
        
      ],
      backgroundColor: Theme.of(context).accentColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: <Widget>[
            SizedBox(height: 100.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
              child: Center(
                  child: Column(
                children: <Widget>[
          
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Text("What can we get you ?",style: TextStyle(fontSize: 16,color: Colors.white),),
                     ],
                   ),
                  SizedBox(height: 15,),
                  Container(
                    child: CupertinoTextField(
                     padding: EdgeInsets.all(15.0),
                      onTap: () {
                        showSearch(context: context, delegate: ProductSearch());
                      },
                      keyboardType: TextInputType.text,
                      placeholder: 'Search for milk and groceries..',
                      placeholderStyle: TextStyle(
                        color: Color(0xffC4C6CC),
                        fontSize: 16.0,
                      ),
                      prefix: Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                        child: Icon(
                          Icons.search,
                          color: Color(0xffC4C6CC),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xffF0F1F5),
                      ),
                    ),
                  )
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
