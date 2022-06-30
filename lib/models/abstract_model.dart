/// Class that defines generic methods for app models
abstract class AbstractModel {
  String? id;

  AbstractModel(this.id);

  /// Create extended class object from Map (dictionary)
  static fromMap() {}

  /// Create Map (dictionary) from extended class parameters
  toMap() {}
}