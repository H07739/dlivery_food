import 'package:flutter/material.dart';

class FutureBuilderX<T> extends StatelessWidget {
  FutureBuilderX({
    super.key,
    required this.future,
    required this.loadingView,
    required this.errorView,
    required this.doneView,
  });

  final Future<T> Function() future; // استخدام دالة لإعادة إنشاء Future
  final ValueNotifier<int> _keyNotifier = ValueNotifier(0);
  final Widget loadingView;
  final Widget Function(String error, ValueNotifier<int> keyNotifier) errorView;
  final Widget Function(T data, ValueNotifier<int> keyNotifier) doneView;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _keyNotifier,
      builder: (BuildContext context, int value, Widget? child) {
        return FutureBuilder<T>(
          future: future(), // استدعاء Future جديد
          key: ValueKey(value),
          builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingView;
            } else if (snapshot.hasError) {
              return Center(
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(onPressed: ()=>_keyNotifier.value++, child: const Text('اعادة المحاولة',style: TextStyle(color: Colors.red),)),
                    )),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return doneView(snapshot.data as T, _keyNotifier);
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        );
      },
    );
  }
}
