import 'package:flutter/cupertino.dart';

// 观察者
class LiveData<T> extends ChangeNotifier {
  T _data;

  T get value => _data;

  set value(T data) {
    _data = data;
    notifyListeners();
  }
}
