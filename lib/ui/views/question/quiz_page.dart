import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ui/provider/main_provider.dart';
import 'package:quiz_app/ui/views/question/provider/question_provider.dart';
import 'package:quiz_app/ui/views/question/show_results.dart';
import 'package:quiz_app/utils/extensions.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionProvider>(
        create: (context) => QuestionProvider(),
        builder: (context, snapshot) {
          return Consumer<QuestionProvider>(
              builder: (context, questionProvider, _) {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      //header
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      var res = await questionProvider.finish();
                                      if (res ?? false) {
                                        var ab = await Get.to(
                                          () => ShowResults(
                                            questionProvider: questionProvider,
                                          ),
                                        );
                                        if (ab ?? false) {
                                          questionProvider.startOver();
                                        } else {
                                          Get.back(result: true);
                                        }
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/icons/logout.svg",
                                    ),
                                    color: Colors.grey,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      "assets/icons/comment.svg",
                                    ),
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/timer.svg",
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${questionProvider.questionDuration.inSeconds.toMinute < 10 ? "0${questionProvider.questionDuration.inSeconds.toMinute}" : questionProvider.questionDuration.inSeconds.toMinute}:${questionProvider.questionDuration.inSeconds.toSecond}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      //indicators
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: questionProvider.questions.length,
                          itemBuilder: (context, index) {
                            return IndicatorWidget(index: index);
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      QuestionWidget(),
                    ],
                  ),
                ),
              ),
              floatingActionButton: context.watch<QuestionProvider>().isFinished
                  ? FloatingActionButton.extended(
                      onPressed: () async {
                        var res = await questionProvider.finish();
                        if (res ?? false) {
                          var ab = await Get.to(() =>
                              ShowResults(questionProvider: questionProvider));
                          if (ab ?? false) {
                            questionProvider.startOver();
                          } else {
                            Get.back(result: true);
                          }
                        }
                      },
                      backgroundColor: Colors.blue,
                      label: const Text(
                        " Testni yakunlash ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            );
          });
        });
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget(
      {required this.index, this.color = Colors.white, super.key});

  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, questionProvider, _) {
        var question = questionProvider.questions[index];
        var isTrue = questionProvider.isTrueQuestion(question['id']);

        return GestureDetector(
          onTap: () {
            questionProvider.currentQuestionIndex = index;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_drop_down,
                color: index == questionProvider.currentQuestionIndex
                    ? Colors.blue
                    : Colors.grey.shade100,
                size: 40,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: isTrue == null
                      ? Colors.white
                      : isTrue
                          ? Colors.green
                          : Colors.red,
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 8),
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: questionProvider.isAnswered(question['id'])
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuestionWidget extends StatelessWidget {
  QuestionWidget({super.key});

  final List alpha = ["A", "B", "C", "D", "E", "F"];

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(builder: (context, questionProvider, _) {
      Map question =
          questionProvider.questions[questionProvider.currentQuestionIndex];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Question text
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Savol:",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  question['text'],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Javoblar",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: question['answers'].length,
            itemBuilder: (context, index) {
              Map answer = question['answers'][index];
              var isTrueAnswer =
                  questionProvider.isTrueAnswer(question['id'], answer['id']);

              var trueAnswerId = questionProvider.trueAnswerId(question['id']);
              bool isAnswered = questionProvider.isAnswered(question['id']);

              return GestureDetector(
                onTap: () {
                  questionProvider.selectAnswer(question['id'], answer['id']);
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: isTrueAnswer == null
                        ? isAnswered && answer['id'] == trueAnswerId
                            ? Colors.green
                            : Colors.white
                        : isTrueAnswer
                            ? Colors.green
                            : Colors.red,
                  ),
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Text(
                        alpha[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isTrueAnswer != null ||
                                  (isAnswered && answer['id'] == trueAnswerId)
                              ? Colors.white
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          answer['text'],
                          style: TextStyle(
                            color: isTrueAnswer != null ||
                                    (isAnswered && answer['id'] == trueAnswerId)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          //For navigate questions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  questionProvider.prevQuestion();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
              ),
              Text(
                "${questionProvider.currentQuestionIndex + 1} / ${questionProvider.questions.length}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  questionProvider.nextQuestion();
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.grey),
              ),
            ],
          )
        ],
      );
    });
  }
}
