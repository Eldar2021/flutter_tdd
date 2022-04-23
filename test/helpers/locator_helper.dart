import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/core/utils/input_convert.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/data/sourses/number_trivia_local_data_source.dart';
import 'package:test_driven_development/features/number_trivia/data/sourses/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_repository.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:test_driven_development/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:test_driven_development/features/number_trivia/presentation/cubit/numbertriviacubit_cubit.dart';

final slTest = GetIt.I;

Future<void> appTestInit() async {
  slTest
    ..registerFactory<NumberTriviaBloc>(MockNumberTriviaBloc.new)
    ..registerFactory<GetConcreteNumberTrivia>(
      MockGetConcreteNumberTrivia.new,
    )
    ..registerFactory<GetRandomNumberTrivia>(
      MockGetRandomNumberTrivia.new,
    )
    ..registerFactory<InputConverter>(MockInputConverter.new)
    ..registerFactory<MockNumberTriviaRepository>(
      MockNumberTriviaRepository.new,
    )
    ..registerFactory<MockNumberTriviaLocalDataSource>(
      MockNumberTriviaLocalDataSource.new,
    )
    ..registerFactory<MokcNumberTriviaRemoteDataSource>(
      MokcNumberTriviaRemoteDataSource.new,
    )
    ..registerFactory<MockNetworkInfo>(MockNetworkInfo.new)
    ..registerFactory<MockHiveBox>(MockHiveBox.new)
    ..registerFactory<MockClient>(MockClient.new)
    ..registerFactory<MockConnectivity>(MockConnectivity.new);
}

class MockNumberTriviaBloc
    extends MockBloc<NumberTriviaEvent, NumberTriviaState>
    implements NumberTriviaBloc {}

class MockNumbertriviacubitCubit extends MockCubit<NumbertriviacubitState>
    implements NumbertriviacubitCubit {}

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

class MockNumberTriviaLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

class MokcNumberTriviaRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockHiveBox extends Mock implements Box<NumberTriviaModel> {}

class MockClient extends Mock implements Client {}

class MockConnectivity extends Mock implements Connectivity {}
