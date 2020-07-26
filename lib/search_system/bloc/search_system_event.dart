import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchSystemEvent extends Equatable {}

class RestartSearchSystemEvent extends SearchSystemEvent {
  @override
  List<Object> get props => [];
}

class SearchTextSearchSystemEvent extends SearchSystemEvent {
  final String searchText;

  SearchTextSearchSystemEvent({@required this.searchText});

  @override
  List<Object> get props => throw UnimplementedError();
}
