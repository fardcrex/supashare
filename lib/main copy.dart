import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase/supabase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage(hasAccessToken: () {
    const storage = FlutterSecureStorage();
    return storage.containsKey(key: supabasePersistSessionKey);
  }, accessToken: () {
    const storage = FlutterSecureStorage();
    return storage.read(key: supabasePersistSessionKey);
  }, removePersistedSession: () {
    const storage = FlutterSecureStorage();
    return storage.delete(key: supabasePersistSessionKey);
  }, persistSession: (String value) {
    const storage = FlutterSecureStorage();
    return storage.write(key: supabasePersistSessionKey, value: value);
  });
  Supabase.initialize(
    localStorage: localStorage,
    url: 'https://owzspkywlhnckhtbkkro.supabase.co',
    debug: true,
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyODEzNDE3OSwiZXhwIjoxOTQzNzEwMTc5fQ.y5-kR5dZTMqjztUtWbTtJ55h039kk8iMFwzbdn4bCks',
    authCallbackUrlHostname: 'login-callback',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        accentColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.green,
          ),
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    final supabase = Supabase.instance.client;

    final response = await supabase.auth.signUp(
      'fardcrex@gmail.com',
      '123456',
      /* options: AuthOptions(redirectTo: 'io.supabase.flutterquickstart://login-callback/') */
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.error!.message),
        backgroundColor: Colors.red,
      ));
    } else {
      print(response.user);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check your email for login link!')));
    }
    setState(() {
      _counter++;
    });
  }

//A user with this email address has already been registered
  String isLogged = '';
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$isLogged',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;
                final user = await supabase.auth.signUp('fardcrex@gmail.com', '123456',
                    options: AuthOptions(redirectTo: 'com.ibernel.supashare://login-callback/'));
                //  final user = await supabase.auth.signIn(email: 'fardcrex@gmail.com', password: '123456');
                //    final user1 = await supabase.auth.api.signInWithEmail('fardcrex@gmail.com', '123456');
                //  supabase.auth.api.setAuthCookie();
                //final user = await supabase.auth.recoverSession(
                //         '{"currentSession":{"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjI4MDk2ODkyLCJzdWIiOiIyZDUxMWEwNC03NmI1LTRhMTMtYTY2Zi05NzE0YzU1ZTU5ZTUiLCJlbWFpbCI6ImZhcmRjcmV4QGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwifSwidXNlcl9tZXRhZGF0YSI6e30sInJvbGUiOiJhdXRoZW50aWNhdGVkIn0.VK0V7zmNVpmDKQutzELLn1spG7vRcawe4KizMgU9JJE","expires_in":30,"refresh_token":"JIDutcDuR3IY88ERNPt7hg","token_type":"bearer","provider_token":null,"user":{"id":"2d511a04-76b5-4a13-a66f-9714c55e59e5","app_metadata":{"provider":"email"},"user_metadata":{},"aud":"authenticated","email":"fardcrex@gmail.com","created_at":"2021-08-04T05:54:08.129219Z","confirmed_at":"2021-08-04T06:01:32.690566Z","last_sign_in_at":"2021-08-04T17:07:42.085337693Z","role":"authenticated","updated_at":"2021-08-04T17:07:42.086847Z"}},"expiresAt":1628096892}');
                // print(supabase.auth.currentUser.runtimeType);

                // supabase.auth.api.getUserByCookie();

                /*      print(response?.aud ?? '');
                print(response?.id ?? ''); */
                //  print(supabase.auth.api.getUser(jwt));
                //   print(user1);
                setState(() {});
                isAuth = true;
                //supabase.auth.api.
                print(user.data?.persistSessionString);
                await storage.write(
                  key: 'persistSessionString',
                  value: user.data?.persistSessionString,
                );

                //  print(user1.data);
              },
              child: Text('Send Magic Link'),
            ),
            ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;

                setState(() {});
                /*    final value = await storage.read(key: supabasePersistSessionKey);
                final user = await supabase.auth.recoverSession(value ?? ''); */

                print(supabase.auth.currentUser);
                isAuth = true;

                if (supabase.auth.currentUser != null) isLogged = supabase.auth.currentUser!.email.toString();
                //print(value);
              },
              child: Text('Verified logged'),
            ),
            ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;

                final value = await supabase.auth.signOut();
              },
              child: Text('Sing Out'),
            ),
            ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;

                final user = supabase.auth.currentUser;
                final updates = {
                  'id': user!.id,
                  'username': 'userName',
                  'website': 'dinamo.app',
                  'updated_at': DateTime.now().toIso8601String(),
                };
                final response = await supabase.from('profiles').upsert(updates).execute();
                /*      print(response?.aud ?? '');
                print(response?.id ?? ''); */
                print(response);
              },
              child: Text('Send Magic Link'),
            ),
            ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;
                final user = supabase.auth.currentUser;
                final image2 = await supabase.storage.from('avatars').download('${user!.id}/avatar4.png');
                bytes = image2.data;
                setState(() {});
                /*      print(response?.aud ?? '');
                print(response?.id ?? ''); */
              },
              child: Text('download'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final request = await HttpClient()
                      .getUrl(Uri.parse('https://pbs.twimg.com/media/E77aCvFXoAAQ-jJ?format=jpg&name=small'));

                  final response = await request.close();

                  bytes = await consolidateHttpClientResponseBytes(response);
                  final supabase = Supabase.instance.client;
                  final user = supabase.auth.currentUser;
                  setState(() {});
                  final storage =
                      await supabase.storage.from('public').uploadBinary('${user!.id}/avatar4.png', bytes!);
                  final image = supabase.storage.from('public').getPublicUrl('${user.id}/avatar4.png');

                  print(image.data);
                  print(storage.data);
                } catch (e) {
                  print(e);
                }

                /*      print(response?.aud ?? '');
                print(response?.id ?? ''); */
              },
              child: Text('Send asdas  Link'),
            ),
            if (bytes != null) Image.memory(bytes!),
            //'https://gauhclieodweabqgqrxs.supabase.in/storage/v1/object/sign/avatars/2d511a04-76b5-4a13-a66f-9714c55e59e5/avatar.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhdmF0YXJzLzJkNTExYTA0LTc2YjUtNGExMy1hNjZmLTk3MTRjNTVlNTllNS9hdmF0YXIucG5nIiwiaWF0IjoxNjI4MDYwMTE2LCJleHAiOjE5NDM0MjAxMTZ9.wlEs7zImrIgWtXlx0Pbcp1nJkejb-t3OGaUmkAADJHU'

            //if (isAuth)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool isAuth = false;
  Uint8List? bytes;
}
