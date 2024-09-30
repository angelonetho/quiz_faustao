import 'questao.dart';

final listaQuestoes = [
  Questao(
    enunciado: "Qual o nome do apresentador do Domingão do Faustão?",
    alternativaCorreta: "Fausto Silva",
    alternativasIncorretas: [
      "Luciano Huck",
      "Rodrigo Faro",
      "Silvio Santos",
    ],
  ),
  Questao(
    enunciado:
        "Em que ano o programa Domingão do Faustão estreou na Rede Globo?",
    alternativaCorreta: "1989",
    alternativasIncorretas: [
      "1987",
      "1991",
      "1993",
    ],
  ),
  Questao(
    enunciado:
        "Qual é o quadro do programa em que bailarinas dançam ao som de diferentes estilos musicais?",
    alternativaCorreta: "Balé da Dança dos Famosos",
    alternativasIncorretas: [
      "Show dos Famosos",
      "Truque Vip",
      "Dança no Gelo",
    ],
  ),
  Questao(
    enunciado:
        "Qual o nome do quadro em que cantores são desafiados a cantar músicas de outros artistas?",
    alternativaCorreta: "Ding Dong",
    alternativasIncorretas: [
      "Dança dos Famosos",
      "Truque Vip",
      "Show dos Famosos",
    ],
  ),
  Questao(
    enunciado:
        "Qual é o nome do jogo em que os participantes devem acertar uma palavra ou frase que está incompleta?",
    alternativaCorreta: "O Show da Vida",
    alternativasIncorretas: [
      "Arquivo Confidencial",
      "Quem Sabe Canta",
      "Dança dos Famosos",
    ],
  ),
  Questao(
    enunciado:
        "Quem é o apresentador que substituiu Fausto Silva no Domingão do Faustão em 2021?",
    alternativaCorreta: "Tiago Leifert",
    alternativasIncorretas: [
      "Marcos Mion",
      "Luciano Huck",
      "Ivete Sangalo",
    ],
  ),
  Questao(
    enunciado:
        "Qual o nome do quadro em que o público envia vídeos de momentos engraçados e curiosos?",
    alternativaCorreta: "Vídeo Cassetadas",
    alternativasIncorretas: [
      "Show dos Famosos",
      "Arquivo Confidencial",
      "Giro da Fama",
    ],
  ),
];

class RepositorioQuestoes {
  final List<Questao> _questoes = List.from(listaQuestoes);

  List<Questao> listar() {
    return _questoes;
  }
}
