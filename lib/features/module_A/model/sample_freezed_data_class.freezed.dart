// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sample_freezed_data_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SampleDataClass _$SampleDataClassFromJson(Map<String, dynamic> json) {
  return _SampleDataClass.fromJson(json);
}

/// @nodoc
mixin _$SampleDataClass {
  int get id => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get isMember => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleDataClassCopyWith<SampleDataClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleDataClassCopyWith<$Res> {
  factory $SampleDataClassCopyWith(
          SampleDataClass value, $Res Function(SampleDataClass) then) =
      _$SampleDataClassCopyWithImpl<$Res>;
  $Res call({int id, String password, bool isMember});
}

/// @nodoc
class _$SampleDataClassCopyWithImpl<$Res>
    implements $SampleDataClassCopyWith<$Res> {
  _$SampleDataClassCopyWithImpl(this._value, this._then);

  final SampleDataClass _value;
  // ignore: unused_field
  final $Res Function(SampleDataClass) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? password = freezed,
    Object? isMember = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isMember: isMember == freezed
          ? _value.isMember
          : isMember // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_SampleDataClassCopyWith<$Res>
    implements $SampleDataClassCopyWith<$Res> {
  factory _$$_SampleDataClassCopyWith(
          _$_SampleDataClass value, $Res Function(_$_SampleDataClass) then) =
      __$$_SampleDataClassCopyWithImpl<$Res>;
  @override
  $Res call({int id, String password, bool isMember});
}

/// @nodoc
class __$$_SampleDataClassCopyWithImpl<$Res>
    extends _$SampleDataClassCopyWithImpl<$Res>
    implements _$$_SampleDataClassCopyWith<$Res> {
  __$$_SampleDataClassCopyWithImpl(
      _$_SampleDataClass _value, $Res Function(_$_SampleDataClass) _then)
      : super(_value, (v) => _then(v as _$_SampleDataClass));

  @override
  _$_SampleDataClass get _value => super._value as _$_SampleDataClass;

  @override
  $Res call({
    Object? id = freezed,
    Object? password = freezed,
    Object? isMember = freezed,
  }) {
    return _then(_$_SampleDataClass(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isMember: isMember == freezed
          ? _value.isMember
          : isMember // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SampleDataClass implements _SampleDataClass {
  const _$_SampleDataClass(
      {required this.id, required this.password, this.isMember = false});

  factory _$_SampleDataClass.fromJson(Map<String, dynamic> json) =>
      _$$_SampleDataClassFromJson(json);

  @override
  final int id;
  @override
  final String password;
  @override
  @JsonKey()
  final bool isMember;

  @override
  String toString() {
    return 'SampleDataClass(id: $id, password: $password, isMember: $isMember)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SampleDataClass &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.isMember, isMember));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(isMember));

  @JsonKey(ignore: true)
  @override
  _$$_SampleDataClassCopyWith<_$_SampleDataClass> get copyWith =>
      __$$_SampleDataClassCopyWithImpl<_$_SampleDataClass>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SampleDataClassToJson(
      this,
    );
  }
}

abstract class _SampleDataClass implements SampleDataClass {
  const factory _SampleDataClass(
      {required final int id,
      required final String password,
      final bool isMember}) = _$_SampleDataClass;

  factory _SampleDataClass.fromJson(Map<String, dynamic> json) =
      _$_SampleDataClass.fromJson;

  @override
  int get id;
  @override
  String get password;
  @override
  bool get isMember;
  @override
  @JsonKey(ignore: true)
  _$$_SampleDataClassCopyWith<_$_SampleDataClass> get copyWith =>
      throw _privateConstructorUsedError;
}
