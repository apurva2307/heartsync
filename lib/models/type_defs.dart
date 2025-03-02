import 'package:my_messaging/models/models.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = Future<Either<Failure, void>>;
