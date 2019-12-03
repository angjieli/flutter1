// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;    // ignore: uri_does_not_exist
import 'dart:js';      // ignore: uri_does_not_exist
import 'dart:js_util' as js_util; // ignore: uri_does_not_exist

/// Registers Web Service Extension for Flutter Web application.
///
/// window.$flutterDriver will be called by Flutter Web Driver to process
/// Flutter Command.
void registerWebServiceExtension(Future<Map<String, dynamic>> Function(Map<String, String>) call) {
  js_util.setProperty(html.window, '\$flutterDriver', allowInterop((dynamic message) async {
    // ignore: undefined_function, undefined_identifier
    final Map<String, String> params = Map<String, String>.from(
        jsonDecode(message));
    final Map<String, dynamic> result = Map<String, dynamic>.from(
        await call(params));
    context['\$flutterDriverResult'] = json.encode(result);
  }));
}