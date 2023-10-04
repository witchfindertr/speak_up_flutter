import 'package:speak_up/data/repositories/local_database/local_database_repository.dart';
import 'package:speak_up/domain/entities/expression_type/expression_type.dart';
import 'package:speak_up/domain/use_cases/use_case.dart';
import 'package:speak_up/injection/injector.dart';

class GetExpressionTypeListUseCase
    implements FutureOutputUseCase<List<ExpressionType>> {
  @override
  Future<List<ExpressionType>> run() async {
    return injector.get<LocalDatabaseRepository>().getExpressionTypeList();
  }
}
