import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(8),
                  controller: controller,
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  autocorrect: true,
                ),
              ),
            ),
            const Text('History'),
            Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                 return ListTile(
                  leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                      child: const Center(
                          child: Text('U',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20)))),
                  title: const Text('Unknown Number'),
                  subtitle: const Text('1234567890'),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
