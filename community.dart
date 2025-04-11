import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스터디 커뮤니티',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal[50],
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          surfaceTint: Colors.transparent,
        ),
      ),
      home: const CommunityScreen(),
    );
  }
}

/// 커뮤니티 글 목록, FAQ, 1:1 문의를 탭(Tab)으로 구성함
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// 예시 게시글 목록
  final List<Post> _posts = [
    Post(
      title: '공부 자료 공유: Flutter 기초',
      author: '김호현',
      content: 'Flutter 설치 및 기본 위젯 정리 자료를 공유합니다.',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Post(
      title: '스터디 후기',
      author: '민재홍',
      content: '어제 진행했던 스터디 후기입니다.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      title: '자료 요청: Firebase 연동',
      author: '오은수',
      content: 'Firebase Auth & Firestore 예제가 있으면 공유 부탁드립니다.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  /// 새 글 작성 예시
  void _addNewPost() {
    setState(() {
      _posts.insert(
        0,
        Post(
          title: '새 글 제목',
          author: '나',
          content: '여기에 글 내용을 작성했습니다.',
          date: DateTime.now(),
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("새 글이 등록되었습니다.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("커뮤니티"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          // 각 탭의 아이콘과 텍스트 색상을 개별적으로 지정
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.list, color: Colors.blueAccent),
                  SizedBox(width: 4),
                  Text("글 목록", style: TextStyle(color: Colors.blueAccent)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.help_outline, color: Colors.green),
                  SizedBox(width: 4),
                  Text("FAQ", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.email_outlined, color: Colors.redAccent),
                  SizedBox(width: 4),
                  Text("1:1 문의", style: TextStyle(color: Colors.redAccent)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// 커뮤니티 글 목록 탭
          CommunityPostsTab(posts: _posts),

          /// FAQ 탭
          FAQTab(),

          /// 1:1 문의 탭
          InquiryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPost,
        child: const Icon(Icons.create_outlined),
      ),
    );
  }
}

/// Post 모델
class Post {
  final String title;
  final String author;
  final String content;
  final DateTime date;

  Post({
    required this.title,
    required this.author,
    required this.content,
    required this.date,
  });
}

/// 커뮤니티 글 목록을 카드 형태로 표시해놓은 것
class CommunityPostsTab extends StatelessWidget {
  final List<Post> posts;

  const CommunityPostsTab({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Center(child: Text("등록된 글이 없습니다."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.content,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "작성자: ${post.author}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      DateFormat('MM/dd HH:mm').format(post.date),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// FAQ 목록을 카드 형태로 표시해놓은 것 - 배경색
class FAQTab extends StatelessWidget {
  final List<FAQItem> faqs = const [
    FAQItem(
      question: "스터디 참여 조건이 있나요?",
      answer: "별도의 조건 없이 누구나 참여 가능합니다.",
    ),
    FAQItem(
      question: "스터디 일정은 어떻게 확인하나요?",
      answer: "앱 내 캘린더 또는 공지 사항을 통해 확인 가능합니다.",
    ),
    FAQItem(
      question: "오프라인 모임 장소는 어떻게 정해지나요?",
      answer: "스터디장(방장)과 참여자들이 협의하여 결정합니다.",
    ),
  ];

  FAQTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final item = faqs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            title: Text(
              item.question,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(item.answer),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// FAQItem 모델
class FAQItem {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
  });
}

/// 1:1 문의 탭 (문의 폼) – 배경색: 보라색
class InquiryTab extends StatefulWidget {
  const InquiryTab({Key? key}) : super(key: key);

  @override
  State<InquiryTab> createState() => _InquiryTabState();
}

class _InquiryTabState extends State<InquiryTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /// 문의 제출
  void _submitInquiry() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("문의가 접수되었습니다.")),
      );
      _titleController.clear();
      _contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        color: Colors.purple[50],
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '제목',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '제목을 입력하세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: '문의 내용',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '문의 내용을 입력하세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitInquiry,
                icon: const Icon(Icons.send_rounded),
                label: const Text('문의하기'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
