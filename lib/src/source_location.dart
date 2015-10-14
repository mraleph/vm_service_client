// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library vm_service_client.source_location;

import 'scope.dart';
import 'script.dart';

VMSourceLocation newVMSourceLocation(Scope scope,
    Map json) {
  if (json == null) return null;
  assert(json["type"] == "SourceLocation");
  return new VMSourceLocation._(scope, json);
}

/// A location or span of code in a Dart script.
class VMSourceLocation {
  /// The script containing the source location.
  final VMScriptRef script;

  /// The canonical source URI of [script].
  Uri get uri => script.uri;

  /// The first token of the location.
  final VMScriptToken start;

  /// The final token of the location, or `null` if this is not a span.
  final VMScriptToken end;

  VMSourceLocation._(Scope scope, Map json)
      : script = newVMScriptRef(scope, json["script"]),
        start = newVMScriptToken(
            scope.isolateId, json["script"]["id"], json["tokenPos"]),
        end = newVMScriptToken(
            scope.isolateId, json["script"]["id"], json["endTokenPos"]);

  String toString() =>
      end == null ? "$script at $start" : "$script from $start to $end";
}