import 'package:collection/collection.dart' as col;

extension IterableExtend<T> on Iterable<T>{

  Map<S, List<T>> groupBy<S>(S Function(T) key)=> col.groupBy(this, key);

}