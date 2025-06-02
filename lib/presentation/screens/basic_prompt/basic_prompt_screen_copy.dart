import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

final user = types.User(
  id: 'user-id-abc',
  firstName: 'Carlos Felipe',
  lastName: 'Araújo',
  imageUrl:
      'https://avatars.githubusercontent.com/u/85801709?s=400&u=01cce0318ea853ce1a133699bc6b2af1919094d6&v=4',
);

final geminiUser = types.User(
  id: 'gemini-id',
  firstName: 'Gemini',
  imageUrl:
      'https://brandlogos.net/wp-content/uploads/2025/03/gemini_icon-logo_brandlogos.net_bqzeu-512x512.png',
);

final now = DateTime.now().millisecondsSinceEpoch;

final messages = <types.Message>[
  types.TextMessage(
    author: user,
    id: Uuid().v4(),
    text:
        'É um app de chat com interface em Flutter e respostas geradas pelo Gemini.',
    createdAt: now - 2000,
  ),
  types.TextMessage(
    author: geminiUser,
    id: Uuid().v4(),
    text: 'Legal! Sobre o que é o projeto que você está desenvolvendo?',
    createdAt: now - 4000,
  ),
  types.TextMessage(
    author: user,
    id: Uuid().v4(),
    text:
        'Oi! Estou fazendo um curso de Flutter + Gemini em DevTalles com o Fernando Herrera.',
    createdAt: now - 6000,
  ),
];

class BasicPromptScreen extends StatelessWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Básico')),
      body: Chat(
        messages: messages,
        onSendPressed: (types.PartialText partialText) {
          debugPrint('Mensagem: ${partialText.text}');
        },
        user: user,
        theme: DarkChatTheme(),
        showUserNames: true,
        showUserAvatars: true,
        avatarBuilder: (user) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color:
                    Colors.white, // visível apenas se a imagem for transparente
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child:
                    user.imageUrl != null && user.imageUrl!.isNotEmpty
                        ? Image.network(
                          user.imageUrl!,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.person, size: 20),
                        )
                        : const Icon(Icons.person, size: 20),
              ),
            ),
          );
        },
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [geminiUser],
          customTypingWidget: const Center(
            child: Text(
              'Só um segundo...',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
