// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/shared/constants/constants.dart';
import 'package:blog_app/core/shared/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blog_app/features/Authentication/data/datasources/remote/auth_remote_source.dart';
import 'package:blog_app/features/Authentication/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;
  AuthRemoteDataSourceImpl({required SupabaseClient client})
      : _supabaseClient = client;

  @override
  Future<UserModel> signinWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        throw AuthServerException(message: 'User is not registered!');
      }
      final userData = {
        'id': response.user!.toJson()['id'],
        'email': response.user!.toJson()['user_metadata']['email'],
        'name': response.user!.toJson()['user_metadata']['name'],
      };

      return UserModel.fromMap(userData);
    } on AuthException catch (e) {
      throw AuthServerException(message: e.message);
    } catch (e) {
      throw AuthServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signupWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await _supabaseClient.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });

      if (response.user == null) {
        throw AuthServerException(message: 'User is not registered!');
      }

      final userData = {
        'id': response.user!.toJson()['id'],
        'email': response.user!.toJson()['user_metadata']['email'],
        'name': response.user!.toJson()['user_metadata']['name'],
      };

      return UserModel.fromMap(userData);
    } on AuthException catch (e) {
      throw AuthServerException(message: e.message);
    } catch (e) {
      throw AuthServerException(message: e.toString());
    }
  }

  @override
  Session? get currentUserSession => _supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final currentUserData = await _supabaseClient
            .from(SupabaseConstants.profilesTable)
            .select('*')
            .eq('id', currentUserSession!.user.id);

        final userData = {
          ...currentUserData.first,
          'email': currentUserSession!.user.email,
        };

        return UserModel.fromMap(userData);
      } else {
        return null;
      }
    } catch (e) {
      throw AuthServerException(message: e.toString());
    }
  }
}
