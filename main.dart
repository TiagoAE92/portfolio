import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Portfólio - Tiago Alexandre Esteves
// Projeto da P2 - Flutter Web

void main() {
  runApp(const PortfolioApp());
}

// ---------- Cores usadas no site ----------
const corFundo = Color(0xFF0F172A);
const corCard = Color(0xFF1E293B);
const corBorda = Color(0xFF334155);
const corDestaque = Color(0xFF38BDF8);
const corTexto = Color(0xFFE2E8F0);
const corTextoSuave = Color(0xFF94A3B8);

// Links reais
const linkLinkedin = 'https://linkedin.com/in/tiago-alexandre-esteves';
const linkGithub = 'https://github.com/TiagoAE92';
const linkRepositorio = 'https://github.com/TiagoAE92/portfolio';
const linkDeploy = 'https://tiagoae92.github.io/portfolio/';
const linkEmail = 'mailto:tiagoesteves1992@gmail.com';

Future<void> abrirLink(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiago Alexandre Esteves | Portfólio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: corFundo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: corDestaque,
          brightness: Brightness.dark,
        ),
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  // Chaves para a navbar rolar até cada seção
  final GlobalKey keyProjetos = GlobalKey();
  final GlobalKey keySobre = GlobalKey();
  final GlobalKey keyContato = GlobalKey();

  void irPara(GlobalKey key) {
    final contexto = key.currentContext;
    if (contexto != null) {
      Scrollable.ensureVisible(
        contexto,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Navbar fica fixa no topo
          Navbar(
            aoClicarProjetos: () => irPara(keyProjetos),
            aoClicarSobre: () => irPara(keySobre),
            aoClicarContato: () => irPara(keyContato),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),

                        // Card de destaque
                        Container(
                          key: keyProjetos,
                          child: CardDestaque(
                            aoClicarGithub: () => abrirLink(linkRepositorio),
                            aoClicarDeploy: () => abrirLink(linkDeploy),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Área visual principal
                        const AreaVisual(),
                        const SizedBox(height: 56),

                        // Problema e solução
                        const SecaoProblemaSolucao(),
                        const SizedBox(height: 56),

                        // Tecnologias
                        const SecaoTecnologias(),
                        const SizedBox(height: 56),

                        // Features
                        const SecaoFeatures(),
                        const SizedBox(height: 56),

                        // Sobre
                        Container(key: keySobre, child: const SecaoSobre()),
                        const SizedBox(height: 56),

                        // Resultados
                        const SecaoResultados(),
                        const SizedBox(height: 56),

                        // Contato
                        Container(
                          key: keyContato,
                          child: const SecaoContato(),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- NAVBAR ----------
class Navbar extends StatelessWidget {
  final VoidCallback aoClicarProjetos;
  final VoidCallback aoClicarSobre;
  final VoidCallback aoClicarContato;

  const Navbar({
    super.key,
    required this.aoClicarProjetos,
    required this.aoClicarSobre,
    required this.aoClicarContato,
  });

  @override
  Widget build(BuildContext context) {
    final bool celular = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: celular ? 12 : 32, vertical: 8),
      decoration: const BoxDecoration(
        color: corCard,
        border: Border(bottom: BorderSide(color: corBorda)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nome à esquerda
          Flexible(
            child: Text(
              'Tiago Alexandre Esteves',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: celular ? 14 : 20,
                fontWeight: FontWeight.bold,
                color: corTexto,
              ),
            ),
          ),
          // Links à direita
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(onPressed: aoClicarProjetos, child: const Text('Projetos')),
              TextButton(onPressed: aoClicarSobre, child: const Text('Sobre')),
              TextButton(onPressed: aoClicarContato, child: const Text('Contato')),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------- Widget auxiliar: título de seção ----------
class TituloSecao extends StatelessWidget {
  final String texto;
  const TituloSecao(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: corTexto,
        ),
      ),
    );
  }
}

// ---------- Widget auxiliar: tag ----------
class Tag extends StatelessWidget {
  final String texto;
  const Tag(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: corDestaque.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(color: corDestaque, fontSize: 13),
      ),
    );
  }
}

// ---------- CARD DE DESTAQUE ----------
class CardDestaque extends StatelessWidget {
  final VoidCallback aoClicarGithub;
  final VoidCallback aoClicarDeploy;

  const CardDestaque({
    super.key,
    required this.aoClicarGithub,
    required this.aoClicarDeploy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: corCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corBorda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Tag('Front-end'),
              Tag('Flutter'),
              Tag('Out 2026'),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Desenvolvimento de um Dashboard E-commerce em Tempo Real',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: corTexto,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Uma aplicação web escalável com atualizações ao vivo, '
            'gráficos interativos e foco total na experiência do usuário (UX).',
            style: TextStyle(fontSize: 16, color: corTextoSuave, height: 1.5),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: aoClicarGithub,
                icon: const Icon(Icons.code),
                label: const Text('Ver Código no GitHub'),
              ),
              FilledButton.icon(
                onPressed: aoClicarDeploy,
                icon: const Icon(Icons.rocket_launch),
                label: const Text('Acessar Deploy'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------- ÁREA VISUAL (mockup simulado) ----------
class AreaVisual extends StatelessWidget {
  const AreaVisual({super.key});

  // Alturas das barras do gráfico falso
  static const List<double> alturas = [60, 100, 80, 130, 110, 150, 120];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corBorda),
      ),
      child: Column(
        children: [
          // Barra de "janela do navegador"
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: corCard,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Row(
              children: [
                CircleAvatar(radius: 6, backgroundColor: Colors.redAccent),
                SizedBox(width: 6),
                CircleAvatar(radius: 6, backgroundColor: Colors.amber),
                SizedBox(width: 6),
                CircleAvatar(radius: 6, backgroundColor: Colors.green),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vendas em tempo real',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: corTexto,
                  ),
                ),
                const SizedBox(height: 20),
                // Gráfico de barras feito só com Containers
                SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final h in alturas)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              height: h,
                              decoration: BoxDecoration(
                                color: corDestaque,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '[ Imagem/GIF demonstrativo da interface da aplicação ]',
                  style: TextStyle(color: corTextoSuave, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- PROBLEMA E SOLUÇÃO ----------
class SecaoProblemaSolucao extends StatelessWidget {
  const SecaoProblemaSolucao({super.key});

  Widget bloco(IconData icone, String titulo, String texto) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: corCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: corBorda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: corDestaque, size: 30),
          const SizedBox(height: 12),
          Text(
            titulo,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: corTexto),
          ),
          const SizedBox(height: 8),
          Text(
            texto,
            style: const TextStyle(color: corTextoSuave, height: 1.5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final desafio = bloco(
      Icons.help_outline,
      'O Desafio',
      'Lojistas precisavam monitorar vendas sem atualizar a página manualmente.',
    );
    final solucao = bloco(
      Icons.lightbulb_outline,
      'A Solução',
      'Criação de um pipeline de dados com WebSockets e renderização otimizada.',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloSecao('O Problema e a Solução'),
        LayoutBuilder(
          builder: (context, constraints) {
            // Em tela pequena fica um embaixo do outro
            if (constraints.maxWidth < 700) {
              return Column(
                children: [desafio, const SizedBox(height: 16), solucao],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: desafio),
                const SizedBox(width: 16),
                Expanded(child: solucao),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ---------- ARQUITETURA E TECNOLOGIAS ----------
class SecaoTecnologias extends StatelessWidget {
  const SecaoTecnologias({super.key});

  // Lista simples: nome e motivo
  static const List<List<String>> tecnologias = [
    ['Flutter', 'Um único código para web e mobile, com interface fluida.'],
    ['Node.js', 'Servidor leve e bom para conexões em tempo real.'],
    ['WebSockets', 'Mantém a comunicação aberta e envia dados na hora.'],
    ['Material 3', 'Componentes prontos e padronizados para a interface.'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloSecao('Arquitetura e Tecnologias'),
        for (final t in tecnologias)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: corDestaque, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${t[0]}: ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: corTexto),
                        ),
                        TextSpan(
                          text: t[1],
                          style: const TextStyle(color: corTextoSuave),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------- FEATURES ----------
class SecaoFeatures extends StatelessWidget {
  const SecaoFeatures({super.key});

  Widget cardFeature(IconData icone, String titulo, String texto) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: corCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: corBorda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: corDestaque, size: 28),
          const SizedBox(height: 12),
          Text(
            titulo,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: corTexto),
          ),
          const SizedBox(height: 6),
          Text(texto, style: const TextStyle(color: corTextoSuave, height: 1.4)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      cardFeature(Icons.devices, 'UI/UX Responsivo',
          'Se adapta a qualquer tamanho de tela.'),
      cardFeature(Icons.bar_chart, 'Gráficos Dinâmicos',
          'Atualização a cada 500ms com gráficos interativos.'),
      cardFeature(Icons.lock_outline, 'Autenticação',
          'Proteção de rotas com JWT.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloSecao('Características Principais'),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 700) {
              return Column(
                children: [
                  for (final c in cards)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(width: double.infinity, child: c),
                    ),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < cards.length; i++) ...[
                  Expanded(child: cards[i]),
                  if (i < cards.length - 1) const SizedBox(width: 16),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

// ---------- SOBRE ----------
class SecaoSobre extends StatelessWidget {
  const SecaoSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloSecao('Sobre'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: corCard,
            borderRadius: BorderRadius.circular(12),
            border: const Border(left: BorderSide(color: corDestaque, width: 4)),
          ),
          child: const Text(
            'Estudante de Desenvolvimento de Software Multiplataforma na FATEC '
            'Osasco, unindo uma sólida base corporativa em finanças e operações '
            'a conhecimentos em programação, banco de dados e engenharia de '
            'software. Focado em construir soluções web eficientes, escaláveis '
            'e com excelente experiência de usuário.',
            style: TextStyle(fontSize: 16, color: corTexto, height: 1.6),
          ),
        ),
      ],
    );
  }
}

// ---------- RESULTADOS ----------
class SecaoResultados extends StatelessWidget {
  const SecaoResultados({super.key});

  Widget topico(String titulo, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(Icons.arrow_right, color: corDestaque),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$titulo: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: corTexto),
                  ),
                  TextSpan(
                    text: texto,
                    style: const TextStyle(color: corTextoSuave),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloSecao('Resultados e Lições Aprendidas'),
        topico('Desempenho',
            'Redução de 40% no tempo de carregamento inicial (LCP).'),
        topico('Aprendizado',
            'Implementação profunda de gerenciamento de estado global.'),
      ],
    );
  }
}

// ---------- CONTATO / RODAPÉ ----------
class SecaoContato extends StatelessWidget {
  const SecaoContato({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: corCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corDestaque),
      ),
      child: Column(
        children: [
          const Text(
            'Vamos trabalhar juntos?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: corTexto),
          ),
          const SizedBox(height: 12),
          const Text(
            'Gostou do projeto? Estou disponível para novos desafios e contratos.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: corTextoSuave),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => abrirLink(linkEmail),
                icon: const Icon(Icons.email_outlined),
                label: const Text('Enviar Mensagem por E-mail'),
              ),
              OutlinedButton.icon(
                onPressed: () => abrirLink(linkLinkedin),
                icon: const Icon(Icons.business_center_outlined),
                label: const Text('Conectar no LinkedIn'),
              ),
              OutlinedButton.icon(
                onPressed: () => abrirLink(linkGithub),
                icon: const Icon(Icons.code),
                label: const Text('GitHub'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            '© 2026 Tiago Alexandre Esteves',
            style: TextStyle(color: corTextoSuave, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
