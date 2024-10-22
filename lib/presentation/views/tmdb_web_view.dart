import 'package:flicko/constants.dart';
import 'package:flicko/data/api.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

class LoginWebView extends StatefulWidget {
  final Function(String sessionId) onLoginSuccess;

  const LoginWebView({super.key, required this.onLoginSuccess});

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final ApiService apiService = ApiService();
  late String requestToken;
  late WebViewController controller;
  late AppLinks appLinks;
  StreamSubscription? sub;

  @override
  void initState() {
    super.initState();
    initializeRequestToken();
    setupAppLinks();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('WebView is $progress% done');
          },
          onPageStarted: (String url) {
            print('Page started: $url'); 
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error: $error');
            showError('HTTP Error: $error');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
            showError('Error loading resource: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigating to: ${request.url}');
            if (request.url.startsWith('myapp://approved')) {
              handleDeepLink(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  void dispose() {
    sub?.cancel(); 
    super.dispose();
  }

  Future<void> initializeRequestToken() async {
    try {
      requestToken = await apiService.createRequestToken() ?? '';
      if (requestToken.isNotEmpty) {
        loadLoginUrl();
      } else {
        showError("Failed to create request token.");
      }
    } catch (e) {
      showError("An error occurred while initializing token.");
    }
  }

  void loadLoginUrl() {
    final Uri loginUrl = Uri.parse(
        'https://www.themoviedb.org/authenticate/$requestToken?redirect_to=myapp://approved');

    controller.loadRequest(loginUrl); 
  }

  void setupAppLinks() {
    appLinks = AppLinks();
    sub = appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print('Received URI: $uri');
        handleDeepLink(uri.toString());
      }
    }, onError: (err) {
      showError("An error occurred with app links.");
    });
  }

  Future<void> handleDeepLink(String url) async {
    if (url.startsWith('myapp://approved')) {
      final sessionId = await apiService.createSession(requestToken);
      if (sessionId != null) {
        widget.onLoginSuccess(sessionId);
        Navigator.pop(context);
      } else {
        showError("Failed to create session.");
      }
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Login to TMDb'),
      ),
      body: WebViewWidget(controller: controller), 
    );
  }
}
