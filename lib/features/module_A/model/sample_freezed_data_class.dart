import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class SampleDataClass with _$SampleDataClass {
  const factory SampleDataClass({
    required int id,
    required String password,
    @Default(false) bool isMemeber,
  }) = _SampleDataClass;
  // use a const factory constructor,
  // which points to a class with the same name as yours.
  // The only difference is that this class has an underscore.

  factory SampleDataClass.fromJson(Map<String, dynamic> json) =>
      _$SampleDataClassFromJson(json);

  // run the command below
  // flutter pub run build_runner build --delete-conflicting-outputs
  /* will automatically generate the following
    toString() 
    ==operator
    hashCode getter variable
    copyWith() 
    toJson() 
  */
}
