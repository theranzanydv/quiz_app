import 'package:flutter/material.dart';

//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quizBrain.dart';

QuizBrain quizBrain = QuizBrain();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> scoreKeeper = [];
  List<Icon> gotCorrect = [];
  List<Icon> gotIncorrect = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    int numberOfCorrect = gotCorrect.length;
    int numberOfIncorrect = gotIncorrect.length;
    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if (quizBrain.isFinished() == true) {
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        Alert(
          context: context,
          type: AlertType.none,
          title: "Quizzler",
          desc: "Correct Answers: $numberOfCorrect \nIncorrect Answers : $numberOfIncorrect",
          style: const AlertStyle(backgroundColor: Colors.white70, isCloseButton: false),
          buttons: [
            DialogButton(
              child: const Text(
                "Reset Quiz",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                // TODO: Step 4 Part C - reset the questionNumber.
                quizBrain.resetQuiz();
                //TODO: Step 4 Part D - empty out the scoreKeeper.
                scoreKeeper.clear();
                gotCorrect.clear();
                gotIncorrect.clear();
                Navigator.pop(context);
              },
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0),
                ],
              ),
            )
          ],
        ).show();
      }

      //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
          gotCorrect.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
          gotIncorrect.add(const Icon(Icons.close, color: Colors.red));
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // quizBrain.questionBank[questionNumber].questionText,
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green, primary: Colors.white),
              child: const Text('True', style: TextStyle(fontSize: 20.0)),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red, primary: Colors.white),
              child: const Text('False', style: TextStyle(fontSize: 20.0)),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
