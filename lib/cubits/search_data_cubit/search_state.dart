part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String searchTerm;
  SearchState({
    required this.searchTerm,
  });

  factory SearchState.initial() {
    return SearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'SearchState(searchTerm: $searchTerm)';

  SearchState copyWith({
    String? searchTerm,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
