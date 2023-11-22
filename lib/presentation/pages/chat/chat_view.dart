import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speak_up/data/models/open_ai/open_ai_message_response.dart';
import 'package:speak_up/data/providers/app_theme_provider.dart';
import 'package:speak_up/domain/use_cases/open_ai/get_message_response_from_open_ai_use_case.dart';
import 'package:speak_up/injection/injector.dart';
import 'package:speak_up/presentation/pages/chat/chat_state.dart';
import 'package:speak_up/presentation/pages/chat/chat_view_model.dart';
import 'package:speak_up/presentation/resources/app_images.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(
    injector<GetMessageResponseFromOpenAIUseCase>(),
  ),
);

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  ChatViewModel get _viewModel => ref.read(chatViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _viewModel.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatViewModelProvider);
    final isDarkTheme = ref.watch(themeProvider);
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(
                    ScreenUtil().setHeight(16) + ScreenUtil().statusBarHeight),
                bottom: ScreenUtil().setHeight(ScreenUtil().setHeight(16)),
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  //avatar
                  CircleAvatar(
                    radius: ScreenUtil().setWidth(ScreenUtil().setWidth(28)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(48),
                        child: AppImages.chatbot()),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(8)),
                  // name
                  Expanded(
                      child: Text(
                    'Teacher Ba',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  SizedBox(width: ScreenUtil().setWidth(8)),
                  //more vert icon
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setWidth(32)),
                    topRight: Radius.circular(ScreenUtil().setWidth(32)),
                  ),
                ),
                child: ListView.builder(
                  //messages example
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return _buildMessage(index, message, isDarkTheme);
                  },
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(ScreenUtil().setWidth(8)),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _viewModel.textEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(8)),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                    ),
                    onPressed: _viewModel.getMessageResponseFromOpenAI,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(int index, Message message, bool isDarkTheme) {
    final isChatBot = message.role == 'system' || message.role == 'assistant';
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(8),
        bottom: ScreenUtil().setHeight(8),
        left: isChatBot ? 8 : ScreenUtil().screenWidth * 0.2,
        right: isChatBot ? ScreenUtil().screenWidth * 0.2 : 8,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          color: isChatBot
              ? Theme.of(context).primaryColor
              : isDarkTheme
                  ? Colors.grey[800]
                  : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDarkTheme
                  ? Colors.black.withOpacity(0.25)
                  : Colors.grey.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: isChatBot ? Radius.zero : const Radius.circular(16),
              topRight: isChatBot ? const Radius.circular(16) : Radius.zero,
              bottomRight: const Radius.circular(16),
              bottomLeft: const Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isChatBot
                    ? Colors.white
                    : isDarkTheme
                        ? Colors.white
                        : Colors.black,
                fontSize: ScreenUtil().setSp(16),
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
