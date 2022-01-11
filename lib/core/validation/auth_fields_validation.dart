import 'package:test_app/core/error/failures.dart';

// class InputConverter {
//   Either<Failure, bool> checkString(String login, String password) {
//     if (login.isNotEmpty && password.isNotEmpty) {
//       return const Right(true);
//     } else {
//       return Left(InvalidInputFailure());
//     }
//   }
// }

class InvalidInputFailure extends Failure {}
