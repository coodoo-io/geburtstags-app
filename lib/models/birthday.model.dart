import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday.model.freezed.dart';

@freezed
class FreezedBirthday with _$FreezedBirthday {
  factory FreezedBirthday({
    required DateTime birthday,
    required String name,
    @Default('') String? notes,
  }) = _FreezedBirthday;
}
