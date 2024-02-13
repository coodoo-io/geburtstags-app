import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday.model.freezed.dart';

@freezed
class Birthday with _$Birthday {
  factory Birthday({
    required DateTime birthday,
    required String name,
    @Default('') String? notes,
  }) = _FreezedBirthday;
}
