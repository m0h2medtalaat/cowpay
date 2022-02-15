import 'package:api_manager/api_manager.dart';
import 'package:cowpay/cowpay/data/datasources/remote_data_source.dart';
import 'package:cowpay/cowpay/data/models/fawry_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApisManager extends Mock implements APIsManager {}

void main() {
  RemoteDataSourceImpl dataSource;
  late MockApisManager mockApisManager;

  setUp(() {
    mockApisManager = MockApisManager();
    dataSource = RemoteDataSourceImpl(mockApisManager);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockApisManager.send(
      request: any as Request,
      responseFromMap: (map) => any as Function(Map<String, dynamic> map),
    )).thenAnswer((_) async => Either());
  }

  void setUpMockHttpClientFailure404() {
    when(mockApisManager.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockApisManager.get(
          'http://numbersapi.com/$tNumber',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRandomNumberTrivia();
        // assert
        verify(mockApisManager.get(
          'http://numbersapi.com/random',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
