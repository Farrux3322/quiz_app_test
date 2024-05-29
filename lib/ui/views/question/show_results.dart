import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ui/views/question/provider/question_provider.dart';
import 'package:quiz_app/utils/extensions.dart';

class ShowResults extends StatefulWidget {
  const ShowResults({required this.questionProvider, super.key});
  final QuestionProvider questionProvider;

  @override
  State<ShowResults> createState() => _ShowResultsState();
}

class _ShowResultsState extends State<ShowResults> {
  int trueAnswersCount = 0;

  @override
  void initState() {
    calculate();
    super.initState();
  }

  void calculate() {
    Map<int, int> answeredQuestionsansweredQuestions =
        widget.questionProvider.answeredQuestions;
    for (Map question in widget.questionProvider.questions) {
      Map trueAnswer = (question['answers'] as List)
          .firstWhere((element) => element['is_true'] ?? false);
      if (answeredQuestionsansweredQuestions[question['id']] ==
          trueAnswer['id']) {
        trueAnswersCount += 1;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double value =
        1 / widget.questionProvider.questions.length * trueAnswersCount;

    return Material(
      child: Center(
        child: Container(
          width: Get.width * .9,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: Offset(2, 2),
                  color: Colors.grey.shade200,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: value),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 10,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "${(value * 100).ceil()}%",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox.square(
                        dimension: 90,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 10,
                          color: value.isBetween(0.0, 0.3)
                              ? Colors.red
                              : value.isBetween(0.31, 0.6)
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                " Yakunlandi ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                trueAnswersCount == 0
                    ? "Afsuski sizga ball taqdim etilmadi"
                    : "Sizga ${trueAnswersCount} ball taqdim etildi",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4.0),
              Text(
                "Ja’mi to’plangan ballaringiz soni: ${trueAnswersCount} ta", //Ja’mi to’plangan ballaringiz soni: 0 ta
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text(
                "Umumiy testlar soni: ${widget.questionProvider.questions.length}", //Ja’mi to’plangan ballaringiz soni: 0 ta
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${trueAnswersCount}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            "To’g’ri javob",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.shade100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.questionProvider.questions.length - trueAnswersCount}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                          const Text(
                            "Noto’g’ri javob",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/timer.svg",
                    color: Colors.orange,
                  ),
                  Text(
                    "10:00 / ${widget.questionProvider.questionDuration.inSeconds.toMinute < 10 ? "0${10 - widget.questionProvider.questionDuration.inSeconds.toMinute}" : widget.questionProvider.questionDuration.inSeconds.toMinute}:${widget.questionProvider.questionDuration.inSeconds.toSecond < 10 ? "0${widget.questionProvider.questionDuration.inSeconds.toSecond}" : widget.questionProvider.questionDuration.inSeconds.toSecond}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              //Qayta topshirish tugmasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.blue,
                        ),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                        minimumSize: const MaterialStatePropertyAll(
                          Size(200, 50),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            "Qayta urinish",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                ],
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
                        overlayColor:
                            MaterialStatePropertyAll(Colors.grey.shade400),
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
                        "Chiqish",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withAlpha(200),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
