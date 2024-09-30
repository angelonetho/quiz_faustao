import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/botao_alternativa.dart';
import 'package:quiz_app/controlador_quiz.dart';
import 'botao_acao.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ControladorQuiz controladorQuiz = ControladorQuiz();

  void _selecionarAlternativa(String alternativa) {
    setState(() {
      controladorQuiz.selecionarAlternativa(alternativa);
    });
  }

  void _reiniciar() {
    setState(() {
      controladorQuiz.restart();
    });
  }

  void _proximaPergunta() {
    setState(() {
      controladorQuiz.acao();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = controladorQuiz.questaoAtual;

    //AudioCache().play('tema.mp3');

    const enumStyle = TextStyle(
        color: Colors.white, backgroundColor: Colors.blue, fontSize: 26);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'logo.png',
              fit: BoxFit.contain,
              height: 64,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Fausto Quiz'))
          ],
        ),
      ),
      body: controladorQuiz.verResultados
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Resultados"),
                const Divider(thickness: 5),
                Text(controladorQuiz.erros == 0
                    ? "${controladorQuiz.acertos} Acertos VOCÊ ACERTOU TUDO, VOCÊ TA SABENDO LEGAL!!!"
                    : "${controladorQuiz.acertos} Acertos"),
                Text("${controladorQuiz.erros} Erros"),
                const Divider(thickness: 5),
                BotaoAcao(
                  texto: "De novo! De novo!!",
                  acao: _reiniciar,
                )
              ],
            ))
          : Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('palco.jpg'), fit: BoxFit.cover)),
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Questão ${controladorQuiz.indiceQuestaoAtual}/${controladorQuiz.quantidadeTotalQuestoes}",
                        style: enumStyle),
                    const Divider(thickness: 5),
                    Text(pergunta.enunciado, style: enumStyle),
                    const Divider(thickness: 5),
                    const SizedBox(height: 10),
                    ...controladorQuiz.questaoAtual.alternativas.map(
                      (alternativa) {
                        return BotaoAlternativa(
                          alternativa: alternativa,
                          acao: _selecionarAlternativa,
                          selecionada: controladorQuiz.alternativaSelecionada ==
                              alternativa,
                          acertou: controladorQuiz.acertouResposta,
                          respondeu: controladorQuiz.respondeuPergunta,
                        );
                      },
                    ),
                    controladorQuiz.status != StatusQuiz.AGUARDAR
                        ? BotaoAcao(
                            texto: controladorQuiz.acabou
                                ? "Resultados"
                                : controladorQuiz.selecionouAlternativa
                                    ? "Responder"
                                    : "Próxima pergunta",
                            acao: _proximaPergunta,
                          )
                        : const SizedBox(
                            height: 100,
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
