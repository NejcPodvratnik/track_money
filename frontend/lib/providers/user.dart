import 'package:flutter_riverpod/flutter_riverpod.dart';

//Models
import 'package:frontend/models/authentication.dart';

//Services
import 'package:frontend/services/user.dart';

class AuthProviderInput {
  AuthProviderInput({
    required this.isSignIn,
    required this.email,
    required this.password,
    this.name,
    this.surname,
  });

  final bool isSignIn;
  final String email;
  final String password;
  final String? name;
  final String? surname;
}

final authProvider = FutureProvider.family<Authentication, AuthProviderInput>(
    ((ref, input) async {
  if (input.isSignIn) {
    return await UserAPI.signup(
        input.email, input.name!, input.surname!, input.password);
  } else {
    return await UserAPI.authenticate(input.email, input.password);
  }
}));
