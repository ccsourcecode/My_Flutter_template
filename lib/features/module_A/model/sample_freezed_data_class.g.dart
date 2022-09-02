// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_freezed_data_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SampleDataClass _$$_SampleDataClassFromJson(Map<String, dynamic> json) =>
    _$_SampleDataClass(
      id: json['id'] as int,
      password: json['password'] as String,
      isMember: json['isMember'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SampleDataClassToJson(_$_SampleDataClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      'isMember': instance.isMember,
    };
