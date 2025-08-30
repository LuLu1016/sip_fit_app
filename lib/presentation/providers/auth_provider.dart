import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_fit/domain/entities/user_entity.dart';

class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({UserEntity? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock login - always succeed for now
    state = state.copyWith(
      isLoading: false,
      user: UserEntity(id: '1', name: 'Young Professional', email: email),
    );
  }

  Future<void> signUp(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock signup - always succeed for now
    state = state.copyWith(
      isLoading: false,
      user: UserEntity(id: '1', name: name, email: email),
    );
  }

  void logout() {
    state = AuthState();
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
