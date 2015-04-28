

class Entry<T> {
  T _value;
  String notes;
  
  
  T get value => _value;
  void set value(T newValue) {
    _value = newValue;
  }
}


//void main() {
//  Entry<int> intEntry = new Entry<int>();
//  Entry<String> strEntry = new Entry<String>();
//  
//  intEntry
//    ..value = 12
//    ..notes = "I'm an integer!";
//  
//  strEntry
//    ..value = "Juan"
//    ..notes = "Mustach";
//  
//}