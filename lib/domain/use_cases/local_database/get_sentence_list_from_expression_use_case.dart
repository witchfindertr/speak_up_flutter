import 'package:speak_up/data/repositories/local_database/local_database_repository.dart';
import 'package:speak_up/domain/entities/sentence/sentence.dart';
import 'package:speak_up/domain/use_cases/use_case.dart';
import 'package:speak_up/injection/injector.dart';

class GetSentenceListFromExpressionUseCase
    implements FutureUseCase<int, List<Sentence>> {
  @override
  Future<List<Sentence>> run(int input) {
    return injector
        .get<LocalDatabaseRepository>()
        .getSentenceListFromExpression(input);
  }
}