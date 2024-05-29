import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/ui/views/question/show_results.dart';

class QuestionProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  get currentQuestionIndex => _currentQuestionIndex;
  set currentQuestionIndex(value) {
    _currentQuestionIndex = value;
    notifyListeners();
  }

  late Timer timer;
  late Duration questionDuration;
  void initTimer() {
    questionDuration = Duration(minutes: 10);
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      questionDuration -= const Duration(seconds: 1);
      notifyListeners();
    });
  }

  QuestionProvider() {
    initTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List questions = [
    {
      "id": 1,
      "text": "Agar mijoz sotib olgan sovutgichda biror bir muammo chiqsa ...",
      "answers": [
        {
          "id": 1,
          "text": "Mijoz servis markaziga olib boradi, servis bepul",
          "is_true": true,
        },
        {
          "id": 2,
          "text":
              "Servis markazi mijozni uyiga keladi, servis xizmati pullik bo'ladi",
          "is_true": false,
        },
        {
          "id": 3,
          "text":
              "Mijozni uyiga servis markazi xizmat ko’rsatish uchun keladi, xizmat bepul faqat zavod tomonidan nosozlik chiqsa.",
          "is_true": false,
        },
        {
          "id": 4,
          "text": "Barcha javoblar noto’g’ri",
          "is_true": false,
        },
      ]
    },
    {
      "id": 2,
      "text": "Agar mijoz sotib olgan sovutgichda biror bir muammo chiqsa ...",
      "answers": [
        {
          "id": 1,
          "text": "Mijoz servis markaziga olib boradi, servis bepul",
          "is_true": true,
        },
        {
          "id": 2,
          "text":
              "Servis markazi mijozni uyiga keladi, servis xizmati pullik bo'ladi",
          "is_true": false,
        },
        {
          "id": 3,
          "text":
              "Mijozni uyiga servis markazi xizmat ko’rsatish uchun keladi, xizmat bepul faqat zavod tomonidan nosozlik chiqsa.",
          "is_true": false,
        },
        {
          "id": 4,
          "text": "Barcha javoblar noto’g’ri",
          "is_true": false,
        },
      ]
    },
    {
      "id": 3,
      "text": "Agar mijoz sotib olgan sovutgichda biror bir muammo chiqsa ...",
      "answers": [
        {
          "id": 1,
          "text": "Mijoz servis markaziga olib boradi, servis bepul",
          "is_true": true,
        },
        {
          "id": 2,
          "text":
              "Servis markazi mijozni uyiga keladi, servis xizmati pullik bo'ladi",
          "is_true": false,
        },
        {
          "id": 3,
          "text":
              "Mijozni uyiga servis markazi xizmat ko’rsatish uchun keladi, xizmat bepul faqat zavod tomonidan nosozlik chiqsa.",
          "is_true": false,
        },
        {
          "id": 4,
          "text": "Barcha javoblar noto’g’ri",
          "is_true": false,
        },
      ]
    },
    {
      "id": 4,
      "text": "Agar mijoz sotib olgan sovutgichda biror bir muammo chiqsa ...",
      "answers": [
        {
          "id": 1,
          "text": "Mijoz servis markaziga olib boradi, servis bepul",
          "is_true": true,
        },
        {
          "id": 2,
          "text":
              "Servis markazi mijozni uyiga keladi, servis xizmati pullik bo'ladi",
          "is_true": false,
        },
        {
          "id": 3,
          "text":
              "Mijozni uyiga servis markazi xizmat ko’rsatish uchun keladi, xizmat bepul faqat zavod tomonidan nosozlik chiqsa.",
          "is_true": false,
        },
        {
          "id": 4,
          "text": "Barcha javoblar noto’g’ri",
          "is_true": false,
        },
      ]
    },
    {
      "id": 5,
      "text": "Agar mijoz sotib olgan sovutgichda biror bir muammo chiqsa ...",
      "answers": [
        {
          "id": 1,
          "text": "Mijoz servis markaziga olib boradi, servis bepul",
          "is_true": true,
        },
        {
          "id": 2,
          "text":
              "Servis markazi mijozni uyiga keladi, servis xizmati pullik bo'ladi",
          "is_true": false,
        },
        {
          "id": 3,
          "text":
              "Mijozni uyiga servis markazi xizmat ko’rsatish uchun keladi, xizmat bepul faqat zavod tomonidan nosozlik chiqsa.",
          "is_true": false,
        },
        {
          "id": 4,
          "text": "Barcha javoblar noto’g’ri",
          "is_true": false,
        },
      ]
    },
    {
      "id": 6,
      "text": "Agar mijoz sotib olgan sovutgichda biror bir muammo chiqsa ...",
      "answers": [
        {
          "id": 1,
          "text": "Mijoz servis markaziga olib boradi, servis bepul",
          "is_true": true,
        },
        {
          "id": 2,
          "text":
              "Servis markazi mijozni uyiga keladi, servis xizmati pullik bo'ladi",
          "is_true": false,
        },
        {
          "id": 3,
          "text":
              "Mijozni uyiga servis markazi xizmat ko’rsatish uchun keladi, xizmat bepul faqat zavod tomonidan nosozlik chiqsa.",
          "is_true": false,
        },
        {
          "id": 4,
          "text": "Barcha javoblar noto’g’ri",
          "is_true": false,
        },
      ]
    },
  ];

  Map<int, int> answeredQuestions = {};

  bool isAnswered(id) {
    return answeredQuestions.containsKey(id);
  }

  bool get isFinished => answeredQuestions.length == questions.length;

  bool? isTrueQuestion(questionId) {
    if (isAnswered(questionId)) {
      int answerId = answeredQuestions[questionId]!;
      Map question =
          questions.firstWhere((element) => element['id'] == questionId);
      Map answer = (question['answers'] as List)
          .firstWhere((element) => element['id'] == answerId);

      if (answer['is_true'] ?? false) {
        return true;
      }
      return false;
    } else {
      return null;
    }
  }

  bool? isTrueAnswer(int questionId, int answerId) {
    if (!isAnswered(questionId) || answeredQuestions[questionId] != answerId) {
      return null;
    }

    Map question =
        questions.firstWhere((element) => element['id'] == questionId);
    Map answer = (question['answers'] as List)
        .firstWhere((element) => element['id'] == answerId);

    if (answer['is_true'] ?? false) {
      return true;
    }
    return false;
  }

  int trueAnswerId(questionId) {
    Map question =
        questions.firstWhere((element) => element['id'] == questionId);

    Map answer = (question['answers'] as List)
        .firstWhere((element) => element['is_true'] == true);

    return answer['id'];
  }

  void selectAnswer(questionId, answerId) {
    if (isAnswered(questionId)) return;
    answeredQuestions[questionId] = answerId;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex == questions.length - 1) return;
    currentQuestionIndex += 1;
    notifyListeners();
  }

  void prevQuestion() {
    if (currentQuestionIndex == 0) return;
    currentQuestionIndex -= 1;
    notifyListeners();
  }

  //Dialogs
  Future<bool> finish() async {
    var res = await Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "",
      titleStyle: const TextStyle(fontSize: .0),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 100,
              child: CircleAvatar(
                minRadius: 100,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  Icons.question_mark_rounded,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              " Haqiqatda ham testni yakunlashni hohlaysizmi? ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              "Belgilanmagan test javoblari xato deb hisobga olinadi",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.grey.shade300,
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                      minimumSize: const MaterialStatePropertyAll(
                        Size(200, 50),
                      ),
                    ),
                    child: Text(
                      "Qaytish",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.red,
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                      minimumSize: MaterialStatePropertyAll(
                        Size(200, 50),
                      ),
                    ),
                    child: const Text(
                      "Yakunlash",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    if (res ?? false) {
      timer.cancel();
      return true;
    } else {
      return false;
    }
  }

  void startOver() {
    answeredQuestions.clear();
    currentQuestionIndex = 0;
    initTimer();
    notifyListeners();
  }
}
