
class StoreErrorModel{
  String? type;
  String? errorMessage;

  StoreErrorModel({this.type, this.errorMessage});

  @override
  String toString() {
    return 'StoreErrorModel{type: $type, errorMessage: $errorMessage}';
  }
}