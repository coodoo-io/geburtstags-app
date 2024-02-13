// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birthday.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Birthday {
  DateTime get birthday => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BirthdayCopyWith<Birthday> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BirthdayCopyWith<$Res> {
  factory $BirthdayCopyWith(Birthday value, $Res Function(Birthday) then) =
      _$BirthdayCopyWithImpl<$Res, Birthday>;
  @useResult
  $Res call({DateTime birthday, String name, String? notes});
}

/// @nodoc
class _$BirthdayCopyWithImpl<$Res, $Val extends Birthday>
    implements $BirthdayCopyWith<$Res> {
  _$BirthdayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthday = null,
    Object? name = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezedBirthdayImplCopyWith<$Res>
    implements $BirthdayCopyWith<$Res> {
  factory _$$FreezedBirthdayImplCopyWith(_$FreezedBirthdayImpl value,
          $Res Function(_$FreezedBirthdayImpl) then) =
      __$$FreezedBirthdayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime birthday, String name, String? notes});
}

/// @nodoc
class __$$FreezedBirthdayImplCopyWithImpl<$Res>
    extends _$BirthdayCopyWithImpl<$Res, _$FreezedBirthdayImpl>
    implements _$$FreezedBirthdayImplCopyWith<$Res> {
  __$$FreezedBirthdayImplCopyWithImpl(
      _$FreezedBirthdayImpl _value, $Res Function(_$FreezedBirthdayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthday = null,
    Object? name = null,
    Object? notes = freezed,
  }) {
    return _then(_$FreezedBirthdayImpl(
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FreezedBirthdayImpl implements _FreezedBirthday {
  _$FreezedBirthdayImpl(
      {required this.birthday, required this.name, this.notes = ''});

  @override
  final DateTime birthday;
  @override
  final String name;
  @override
  @JsonKey()
  final String? notes;

  @override
  String toString() {
    return 'Birthday(birthday: $birthday, name: $name, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezedBirthdayImpl &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, birthday, name, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedBirthdayImplCopyWith<_$FreezedBirthdayImpl> get copyWith =>
      __$$FreezedBirthdayImplCopyWithImpl<_$FreezedBirthdayImpl>(
          this, _$identity);
}

abstract class _FreezedBirthday implements Birthday {
  factory _FreezedBirthday(
      {required final DateTime birthday,
      required final String name,
      final String? notes}) = _$FreezedBirthdayImpl;

  @override
  DateTime get birthday;
  @override
  String get name;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$FreezedBirthdayImplCopyWith<_$FreezedBirthdayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
