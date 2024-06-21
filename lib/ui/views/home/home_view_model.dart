import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends AppBaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
