import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speak_up/domain/use_cases/firestore/progress/get_flash_card_list_use_case.dart';
import 'package:speak_up/presentation/pages/saved_flashcards/saved_flashcards_state.dart';
import 'package:speak_up/presentation/utilities/enums/loading_status.dart';

class SavedFlashCarsViewModel extends StateNotifier<SavedFlashCardsState> {
  final GetFlashCardListUseCase _getFlashCardListUseCase;
  SavedFlashCarsViewModel(
    this._getFlashCardListUseCase,
  ) : super(const SavedFlashCardsState());

  Future<void> fetchFlashCardList() async {
    try {
      state = state.copyWith(loadingStatus: LoadingStatus.loading);
      final flashCardList = await _getFlashCardListUseCase.run();
      state = state.copyWith(
        flashCardList: flashCardList,
        loadingStatus: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        loadingStatus: LoadingStatus.error,
      );
    }
  }
}