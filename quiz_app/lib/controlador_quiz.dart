import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

import './repositorio_questoes.dart';
import 'questao.dart';

/* Enum para determinar qual o status do Quiz */
enum StatusQuiz {
  AGUARDAR,
  RESPONDER,
  PROXIMA,
  FINALIZAR,
  RESULTADOS,
}

class ControladorQuiz {
  // repositório responsável por fornecer as questões
  final repositorio = RepositorioQuestoes();

  // indica qual o texto da alternativa selecionada
  String _alternativaSelecionada = "";

  // utiliza a enum para indicar qual o status atual do quiz
  StatusQuiz _status = StatusQuiz.AGUARDAR;

  // indica se o usuario respondeu
  bool _respondeu = false;

  // controla a questão atual
  int _indiceQuestaoAtual = 0;
  int _acertos = 0;

  int get erros => repositorio.listar().length - acertos;

  int get acertos => _acertos;

  int get indiceQuestaoAtual => _indiceQuestaoAtual + 1;

  Questao get questaoAtual => repositorio.listar()[_indiceQuestaoAtual];

  int get quantidadeTotalQuestoes => repositorio.listar().length;

  StatusQuiz get status => _status;

  String get alternativaSelecionada => _alternativaSelecionada;

  bool get selecionouAlternativa => _status == StatusQuiz.RESPONDER;

  bool get respondeuPergunta => _respondeu;

  bool get acertouResposta =>
      (questaoAtual.alternativaCorreta == _alternativaSelecionada);

  bool get acabou => _status == StatusQuiz.FINALIZAR;

  bool get verResultados => _status == StatusQuiz.RESULTADOS;

  void selecionarAlternativa(String alternativa) {
    if (!_respondeu) {
      _alternativaSelecionada = alternativa;
      _status = StatusQuiz.RESPONDER;
    }
  }

  //reinicia o show do milhão
  void restart() {
    _indiceQuestaoAtual = 0;
    _alternativaSelecionada = "";
    _respondeu = false;
    _status = StatusQuiz.AGUARDAR;
    AudioCache().play('pergunta.mp3');
    _acertos = 0;
  }

  //método que determina o que fazer quando clicar no botão
  //de ação. Depende da variável _status.
  void acao() {
    //o usuário clicou em responder
    if (_status == StatusQuiz.RESPONDER) {
      _respondeu = true;

      //registra o número de acertos
      Random random = new Random();
      int randomNumber = random.nextInt(3);
      print('$randomNumber');
      if (acertouResposta) {
        _acertos++;
        if (randomNumber > 0) {
          AudioCache().play('acertou.mp3');
        } else {
          AudioCache().play('faustao-oloko-meu.mp3');
        }
      } else {
        if (randomNumber > 0) {
          AudioCache().play('faustao.mp3');
        } else {
          AudioCache().play('ce-vai-morre-faustao.mp3');
        }
      }

      //verifica se terminou
      if (_indiceQuestaoAtual == quantidadeTotalQuestoes - 1) {
        _status = StatusQuiz.FINALIZAR;
      } else {
        _status = StatusQuiz.PROXIMA;
      }
    } else if (_status == StatusQuiz.PROXIMA) {
      //passa para a próxima pergunta
      if (_indiceQuestaoAtual < quantidadeTotalQuestoes - 1) {
        _indiceQuestaoAtual += 1;
        _alternativaSelecionada = "";
        _respondeu = false;
        _status = StatusQuiz.AGUARDAR;
        AudioCache().play('pergunta.mp3');
      }
      //se terminou mostrar os resultados
    } else if (_status == StatusQuiz.FINALIZAR) {
      _status = StatusQuiz.RESULTADOS;
      if (erros == 0) {
        AudioCache().play('faustao-rap-do-ovo.mp3');
        return;
      }

      if (acertos == 0) {
        AudioCache().play('ninguem-acertou.mp3');
        return;
      }

      if (acertos >= erros && erros > 0) {
        AudioCache().play('faustao-oloko-meu.mp3');
      } else {
        AudioCache().play('horadealegria.mp3');
      }
    }
  }
}
