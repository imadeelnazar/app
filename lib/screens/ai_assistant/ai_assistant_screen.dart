import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../services/ai_assistant_service.dart';
import '../../widgets/app_chrome.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final AiAssistantService _service = AiAssistantService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<AiAssistantMessage> _messages = [];
  AiAssistantAttachment? _attachment;
  bool _isLoading = true;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadMemory();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMemory() async {
    final history = await _service.loadHistory();
    if (!mounted) return;
    setState(() {
      _messages = history;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  Future<void> _pickAttachment() async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.single;
    final bytes = file.bytes ??
        (file.path == null ? null : await File(file.path!).readAsBytes());
    if (bytes == null || bytes.isEmpty) return;
    if (bytes.length > 4 * 1024 * 1024) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image 4MB se choti honi chahiye.')),
      );
      return;
    }

    if (!mounted) return;
    setState(() {
      _attachment = AiAssistantAttachment(
        name: file.name,
        mimeType: _mimeTypeForName(file.name),
        bytes: bytes,
      );
    });
  }

  String _mimeTypeForName(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  Future<void> _send() async {
    final question = _controller.text.trim();
    final attachment = _attachment;
    if ((question.isEmpty && attachment == null) || _isSending) return;

    final userMessage = AiAssistantMessage(
      role: 'user',
      content: question.isEmpty
          ? 'Attachment Islamic context mein explain karein.'
          : question,
      createdAt: DateTime.now(),
      attachmentName: attachment?.name,
    );
    setState(() {
      _messages = [..._messages, userMessage];
      _isSending = true;
      _attachment = null;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final answer = await _service.ask(question, attachment: attachment);
      if (!mounted) return;
      setState(() {
        _messages = [..._messages, answer];
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _messages = [
          ..._messages,
          AiAssistantMessage(
            role: 'assistant',
            content:
                'Maazrat, abhi jawab connect nahi ho pa raha. API key/build config ya internet check kar lein.',
            createdAt: DateTime.now(),
          ),
        ];
      });
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  Future<void> _clearMemory() async {
    await _service.clearHistory();
    if (!mounted) return;
    setState(() => _messages = []);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: hidayatAppBar(
        context,
        title: 'Ayatollah Khamenei',
        actions: [
          IconButton(
            tooltip: 'Clear memory',
            onPressed: _messages.isEmpty ? null : _clearMemory,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      bottomNavigationBar: const HidayatBottomNav(currentIndex: 0),
      body: Column(
        children: [
          const _AssistantIntro(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? _SuggestionList(onPick: _sendSuggestion)
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
                        itemCount: _messages.length + (_isSending ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (_isSending && index == _messages.length) {
                            return const _TypingBubble();
                          }
                          return _MessageBubble(message: _messages[index]);
                        },
                      ),
          ),
          SafeArea(
            top: false,
            child: _Composer(
              controller: _controller,
              attachment: _attachment,
              isSending: _isSending,
              onAttach: _pickAttachment,
              onRemoveAttachment: () => setState(() => _attachment = null),
              onSend: _send,
            ),
          ),
        ],
      ),
    );
  }

  void _sendSuggestion(String text) {
    _controller.text = text;
    _send();
  }
}

class _AssistantIntro extends StatelessWidget {
  const _AssistantIntro();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDDEBE6)),
      ),
      child: const Row(
        children: [
          _KhameneiAvatar(size: 44),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Fiqa Jafria Islamic Q&A only. For binding fatwa, apne marja ya qualified alim se confirm karein.',
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KhameneiAvatar extends StatelessWidget {
  final double size;

  const _KhameneiAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        ayatollahKhameneiImageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          color: hidayatTeal,
          child: const Icon(Icons.person_rounded, color: Colors.white),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  final ValueChanged<String> onPick;

  const _SuggestionList({required this.onPick});

  @override
  Widget build(BuildContext context) {
    const suggestions = [
      'Fiqa Jafria mein namaz ke wajibaat kya hain?',
      'Wuzu tootne wali cheezen batayein',
      'Khums kis par wajib hota hai?',
      'Ziyarat Ashura ki fazilat simple alfaaz mein batayein',
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
      children: [
        const Text(
          'Ask anything to Ayatollah Khamenei',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (final suggestion in suggestions)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => onPick(suggestion),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline_rounded,
                          color: hidayatTeal, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          suggestion,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final AiAssistantMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? hidayatTeal : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isUser ? null : Border.all(color: const Color(0xFFDDEBE6)),
        ),
        child: Text(
          message.attachmentName == null
              ? message.content
              : '${message.content}\n\nAttachment: ${message.attachmentName}',
          style: TextStyle(
            color: isUser ? Colors.white : const Color(0xFF1F2937),
            fontSize: 14,
            height: 1.42,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFDDEBE6)),
        ),
        child: const Text(
          'Ayatollah Khamenei jawab tayyar kar rahe hain...',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final AiAssistantAttachment? attachment;
  final bool isSending;
  final VoidCallback onAttach;
  final VoidCallback onRemoveAttachment;
  final VoidCallback onSend;

  const _Composer({
    required this.controller,
    required this.attachment,
    required this.isSending,
    required this.onAttach,
    required this.onRemoveAttachment,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFDDEBE6))),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Attach image',
            onPressed: isSending ? null : onAttach,
            icon: const Icon(Icons.attach_file_rounded),
            color: hidayatTeal,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (attachment != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF8F6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFDDEBE6)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.image_rounded,
                            size: 18, color: hidayatTeal),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            attachment!.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onRemoveAttachment,
                          child: const Icon(Icons.close_rounded, size: 18),
                        ),
                      ],
                    ),
                  ),
                TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: 'Ayatollah Khamenei se sawal likhein...',
                    filled: true,
                    fillColor: const Color(0xFFF4F8F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: isSending ? null : onSend,
            style: FilledButton.styleFrom(
              backgroundColor: hidayatTeal,
              minimumSize: const Size(48, 48),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}
