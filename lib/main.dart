import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo/actions/navigationActions.dart';
import "package:flutter_todo/pages/completedPage.dart";
import "package:flutter_todo/pages/createEditPage.dart";
import "package:flutter_todo/pages/inboxPage.dart";
import "package:flutter_todo/pages/mainPage.dart";
import 'package:flutter_todo/routes.dart';
import 'package:flutter_todo/states/appState.dart';
import 'package:flutter_todo/store.dart';

void main() {
  runApp(new ReduxApp());
}

class ReduxApp extends StatelessWidget {
  ReduxApp();

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: "ToDo",
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ToDoAppRoutes.inbox,
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  MaterialPageRoute _generateRoute(RouteSettings settings) {
    store.dispatch(new NavigationActionChangeRoute(settings.name));
    switch (settings.name) {
      case ToDoAppRoutes.inbox:
        return new MyCustomRoute(
          builder: (_) => new MainPage("Inbox", new InboxPage(), true),
          settings: settings,
        );
      case ToDoAppRoutes.completed:
        return new MyCustomRoute(
          builder: (_) => new MainPage("Completed", new CompletedPage(), false),
          settings: settings,
        );
      case ToDoAppRoutes.create:
        return MaterialPageRoute(
          builder: (_) => new CreateEditPage(),
          settings: settings,
        );
    }
    assert(false);
    return null;
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
