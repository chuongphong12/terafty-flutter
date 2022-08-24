import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terafty_flutter/bloc/auth/auth_bloc.dart';
import 'package:terafty_flutter/bloc/comment/comment_bloc.dart';
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
import 'package:terafty_flutter/repository/user_repository.dart';
import 'package:terafty_flutter/screens/auth/login_main_screen.dart';
import 'package:terafty_flutter/screens/home/home_screen.dart';
import 'package:terafty_flutter/services/storage_service.dart';
import 'package:terafty_flutter/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  final StorageService _storageService = StorageService();

  MyApp({Key? key}) : super(key: key);

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
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepositories: context.read<AuthRepositories>(),
              storageService: _storageService,
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              authRepositories: context.read<AuthRepositories>(),
              storageService: _storageService,
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
          ),
          BlocProvider(
            create: (context) => CommentBloc(
              streamingRepository: context.read<StreamingRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          title: 'Terafty Flutter',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: (context, child) => BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              print(state.status);
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (route) => false);
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushNamedAndRemoveUntil<void>(
                    LoginMainScreen.routeName,
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unknown:
                  break;
              }
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
