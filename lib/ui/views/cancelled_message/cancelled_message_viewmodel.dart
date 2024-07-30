import 'package:stacked/stacked.dart';

class CancelledMessageViewModel extends BaseViewModel {
  int _latestOrderId = 0;

  int get latestOrderId => _latestOrderId;

 
  void setLatestOrderId(int id) {
    _latestOrderId = id;
    notifyListeners();  
  }

  
}
