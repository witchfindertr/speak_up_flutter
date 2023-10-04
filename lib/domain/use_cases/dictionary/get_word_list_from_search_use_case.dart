import 'package:speak_up/data/repositories/dictionary/dictionary_repository.dart';
import 'package:speak_up/domain/use_cases/use_case.dart';
import 'package:speak_up/injection/injector.dart';

class GetWordListFromSearchUseCase
    implements FutureUseCase<String, List<String>?> {
  @override
  Future<List<String>?> run(String input) async {
    String inputLowerCase = input.toLowerCase();
    final expression = '^$inputLowerCase';
    final response =
        await injector.get<DictionaryRepository>().searchWord(expression);
    return response.results?.data;
  }
}
