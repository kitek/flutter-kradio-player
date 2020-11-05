import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app.dart';
import 'repository/api_client.dart';
import 'repository/station_repository.dart';
import 'simple_bloc_delegate.dart';

void main() {
  int _id = null;
  
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final repository = StationRepository(
    apiClient: ApiClient(httpClient: http.Client()),
  );
  
  print("Awesome print!");

  runApp(App(repository: repository));
}
