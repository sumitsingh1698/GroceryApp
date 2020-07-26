import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:GroceryApp/search_system/bloc/search_system_event.dart';
import 'package:GroceryApp/search_system/bloc/search_system_state.dart';
import 'package:GroceryApp/search_system/model/algolia_key.dart';
import 'package:algolia/algolia.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSystemBloc extends Bloc<SearchSystemEvent, SearchSystemState> {
  @override
  SearchSystemState get initialState => InitSeachSystemState();

  @override
  Stream<SearchSystemState> mapEventToState(SearchSystemEvent event) async* {
    if (event is SearchTextSearchSystemEvent) {
      List<AlgoliaObjectSnapshot> _results = [];
      yield LoadingSearchSystemState();
      AlgoliaQuery q = AlogliaKey.algolia.instance.index('products');
      q = q.search(event.searchText);
      print(q);

      _results = (await q.getObjects()).hits;
      List<Product> _products ;
      for (int index = 0; index < _results.length; index++) {
         AlgoliaObjectSnapshot snap = _results[index];
          print(snap.data['name']);
        yield SuccessSerachSystemState(products: _products);
      }
    }
  }
}
