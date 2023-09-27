import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonToDart extends StatefulWidget {
  const JsonToDart({super.key});

  @override
  State<JsonToDart> createState() => _JsonToDartState();
}

class _JsonToDartState extends State<JsonToDart> {
  final TextEditingController _jsonController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  String _dartCode = '';

  bool isNullable = false;
  bool isLate = false;
  bool isRequired = false;


  void _convertToJsonToDart() {
    final jsonText = _jsonController.text;
    try {
      final className = _classNameController.text.trim();
      final dynamic jsonData = jsonDecode(jsonText);
      final dartCode = _generateDartCode(className, jsonData);
      setState(() {
        _dartCode = dartCode;
      });
    } catch (e) {
      setState(() {
        _dartCode = 'Error parsing JSON: $e';
      });
    }
  }

  String _generateDartCode(String className, dynamic json) {
    final StringBuffer buffer = StringBuffer();

    if (json is Map) {
      buffer.writeln('class $className {');

      // Generate fields
      for (final key in json.keys) {
        final dynamic value = json[key];
        if (value is String) {
          buffer.writeln(
              '  ${isLate ? 'late' : ''} final String${isNullable ? '?' : ''} $key;');
        } else if (value is int) {
          buffer.writeln(
              '  ${isLate ? 'late' : ''} final int${isNullable ? '?' : ''} $key;');
        } else if (value is double) {
          buffer.writeln(
              '  ${isLate ? 'late' : ''} final double${isNullable ? '?' : ''} $key;');
        } else if (value is bool) {
          buffer.writeln(
              '  ${isLate ? 'late' : ''} final bool${isNullable ? '?' : ''} $key;');
        } else if (value is Map) {
          final nestedClassName = '${key[0].toUpperCase()}${key.substring(1)}';
          buffer.writeln(
              '  ${isLate ? 'late' : ''} final $nestedClassName${isNullable ? '?' : ''} $key;');
        } else if (value is List) {
          if (value.isNotEmpty) {
            final listElementType = value[0].runtimeType;
            final listTypeName = _getListTypeName(listElementType);
            buffer.writeln(
                '  ${isLate ? 'late' : ''} final List<$listTypeName>${isNullable ? '?' : ''} $key;');
          } else {
            // Handle empty list case
            buffer.writeln(
                '  ${isLate ? 'late' : ''} final List<dynamic>${isNullable ? '?' : ''} $key;');
          }
        }
      }

      // Generate constructor
      buffer.writeln('');
      buffer.writeln('  $className({');
      final keys = json.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        final key = keys[i];
        buffer.write('    ${isRequired ? 'required' : ''} this.$key');
        if (i < keys.length - 1) {
          buffer.write(',');
        }
        buffer.writeln();
      }
      buffer.writeln('  });');

      // Generate fromJson method
      buffer.writeln('');
      buffer.writeln(
          '  factory $className.fromJson(Map<String, dynamic> json) {');
      buffer.writeln('    return $className(');
      for (var i = 0; i < keys.length; i++) {
        final key = keys[i];
        buffer.write('      $key: json["$key"]');
        if (i < keys.length - 1) {
          buffer.write(',');
        }
        buffer.writeln();
      }
      buffer.writeln('    );');
      buffer.writeln('  }');

      // Generate toJson method
      buffer.writeln('');
      buffer.writeln('  Map<String, dynamic> toJson() {');
      buffer.writeln('    return {');
      for (var i = 0; i < keys.length; i++) {
        final key = keys[i];
        buffer.write('      "$key": $key');
        if (i < keys.length - 1) {
          buffer.write(',');
        }
        buffer.writeln();
      }
      buffer.writeln('    };');
      buffer.writeln('  }');

      buffer.writeln('}');
      buffer.writeln('');

      // Generate separate Dart classes for nested objects
      for (final key in json.keys) {
        final dynamic value = json[key];
        if (value is Map) {
          final nestedClassName = '${key[0].toUpperCase()}${key.substring(1)}';
          buffer.write(_generateDartCode(nestedClassName, value));
        }
      }
    }

    return buffer.toString();
  }

  String _getListTypeName(Type type) {
    if (type == String) {
      return 'String${isNullable ? '?' : ''}';
    } else if (type == int) {
      return 'int${isNullable ? '?' : ''}';
    } else if (type == double) {
      return 'double${isNullable ? '?' : ''}';
    } else if (type == bool) {
      return 'bool${isNullable ? '?' : ''}';
    } else {
      return 'dynamic';
    }
  }

  void _copyResponseToClipboard() {
    Clipboard.setData(ClipboardData(text: _dartCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Response copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON to Dart Converter'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _classNameController,
              decoration: const InputDecoration(
                labelText: 'Enter Class Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _jsonController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Enter JSON data',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: isNullable,
                      onChanged: (newValue) {
                        setState(() {
                          isNullable = newValue ?? false;
                        });
                      },
                    ),
                    const Text('Nullable'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: isLate,
                      onChanged: (newValue) {
                        setState(() {
                          isLate = newValue ?? false;
                        });
                      },
                    ),
                    const Text('Late'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: isRequired,
                      onChanged: (newValue) {
                        setState(() {
                          isRequired = newValue ?? false;
                        });
                      },
                    ),
                    const Text('Required'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertToJsonToDart,
              child: const Text('Convert to Dart'),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SelectableText(
                      _dartCode,
                      style: const TextStyle(fontFamily: 'Courier New'),
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      onPressed: _copyResponseToClipboard,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8.0),
                        shape: const CircleBorder(),
                      ),
                      icon: const Icon(Icons.copy),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
