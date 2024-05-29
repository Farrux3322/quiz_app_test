import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ui/views/question/provider/question_provider.dart';
import 'package:quiz_app/ui/views/question/quiz_page.dart';
import 'package:quiz_app/utils/extensions.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(builder: (context, questionProvider, _) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: .2,
                            blurRadius: 5,
                            color: Colors.grey.shade200,
                            offset: const Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        title: const Text("Quiz Title"),
                        subtitle: Text(
                          DateTime.now().prettyDateTime,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ).marginOnly(bottom: 8);
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    print('111111');
                    Get.to(() => const QuizPage());
                  },
                  style: ButtonStyle(
                    minimumSize: const MaterialStatePropertyAll(
                      Size(double.infinity, 55),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.blue),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Start New Quiz",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ));
    });
  }
}
