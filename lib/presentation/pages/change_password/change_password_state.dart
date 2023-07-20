import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speak_up/presentation/utilities/enums/loading_status.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(false) bool isCurrentPasswordVisible,
    @Default(false) bool isNewPasswordVisible,
    @Default('') String errorMessage,
    @Default(LoadingStatus.initial) LoadingStatus loadingStatus,
  }) = _ChangePasswordState;
}
