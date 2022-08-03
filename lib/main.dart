import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terafty_flutter/bloc/auth/auth_bloc.dart';
import 'package:terafty_flutter/bloc/episode/episode_bloc.dart';
import 'package:terafty_flutter/bloc/login/login_bloc.dart';
import 'package:terafty_flutter/bloc/popular/popular_bloc.dart';
import 'package:terafty_flutter/bloc/streaming/streaming_bloc.dart';
import 'package:terafty_flutter/bloc/vote/vote_bloc.dart';
import 'package:terafty_flutter/configs/app_router.dart';
import 'package:terafty_flutter/configs/theme.dart';
import 'package:terafty_flutter/repository/auth_repository.dart';
import 'package:terafty_flutter/repository/popular_repository.dart';
import 'package:terafty_flutter/repository/streaming_repository.dart';
import 'package:terafty_flutter/screens/auth/login_main_screen.dart';
import 'package:terafty_flutter/screens/home/home_screen.dart';
import 'package:terafty_flutter/services/storage_service.dart';
import 'package:terafty_flutter/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositories(),
        ),
        RepositoryProvider(
          create: (context) => PopularRepository(),
        ),
        RepositoryProvider(
          create: (context) => StreamingRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepositories: context.read<AuthRepositories>(),
              storageService: StorageService(),
            )..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              authRepositories: context.read<AuthRepositories>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => PopularBloc(
              popularRepository: context.read<PopularRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => StreamingBloc(
              streamingRepository: context.read<StreamingRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => EpisodeBloc(
              streamingRepository: context.read<StreamingRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => VoteBloc(
              streamingRepository: context.read<StreamingRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Terafty Flutter',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const HomeScreen();
              }
              if (state is AuthUnAuthenticated) {
                return const LoginMainScreen();
              }
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
    );
  }
}
