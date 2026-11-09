import 'dart:ffi';
import 'dart:io';

import 'algorithm_engine_bindings_generated.dart';

const String _libName = 'algorithm_engine';

final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }

  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }

  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }

  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final AlgorithmEngineBindings _bindings = AlgorithmEngineBindings(_dylib);

int algorithmAdd(int a, int b) {
  return _bindings.algorithm_add(a, b);
}

int algorithmSubtraction(int a, int b) {
  return _bindings.algorithm_subtract(a, b);
}

int algorithmMultiplication(int a, int b) {
  return _bindings.algorithm_multiplication(a, b);
}

int algorithmDivision(int a, int b) {
  return _bindings.algorithm_division(a, b);
}
