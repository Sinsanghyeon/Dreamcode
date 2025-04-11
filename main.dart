import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스터디 그룹 모집',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal[50],
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          surfaceTint: Colors.transparent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/// 스터디 카테고리 모델
class StudyCategory {
  final String name;
  final IconData icon;
  final List<String> subcategories;

  const StudyCategory({
    required this.name,
    required this.icon,
    required this.subcategories,
  });
}

/// 모집글 모델
class RecruitmentPost {
  final String title;
  final String description;
  final String location;
  final String time;

  const RecruitmentPost({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
  });
}

/// 홈 화면: 가로 스크롤 카테고리와 스터디 그룹 모집글 리스트를 포함
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final List<StudyCategory> categories = const [
    StudyCategory(
      name: '지역 선택',
      icon: Icons.location_on,
      subcategories: ['서울', '경기', '부산', '대구', '광주', '대전', '인천', '울산'],
    ),
    StudyCategory(
      name: '외국어',
      icon: Icons.language,
      subcategories: ['일본어', '영어', '중국어', '스페인어', '프랑스어', '독일어'],
    ),
    StudyCategory(
      name: '면접',
      icon: Icons.mic,
      subcategories: ['공기업 면접', '대기업 면접', 'IT 기업 면접', '스타트업 면접'],
    ),
    StudyCategory(
      name: '자격증',
      icon: Icons.school,
      subcategories: ['국가자격증', '공인민간자격증', '민간자격증', '어학자격증'],
    ),
  ];

  final List<RecruitmentPost> posts = const [
    RecruitmentPost(
      title: '[모집] 영어 회화 스터디',
      description:
      '영어 회화 능력 향상을 목표로 하는 스터디 그룹입니다. 주 2회 모임에서 다양한 주제의 토론 및 실습을 진행합니다. 관심 있는 분은 지원해주세요!',
      location: '서울 종로',
      time: '매주 화, 목, 18:00',
    ),
    RecruitmentPost(
      title: '[모집] 웹 개발 스터디',
      description:
      'React, Vue 등 다양한 웹 프레임워크를 다루는 웹 개발 스터디입니다. 주 1회 모임에서 프로젝트를 진행합니다.',
      location: '대구',
      time: '매주 일요일, 14:00',
    ),
    RecruitmentPost(
      title: '[모집] 면접 준비 스터디',
      description:
      '공기업 및 대기업 면접 대비를 위한 스터디 그룹입니다. 실제 면접 질문을 기반으로 모의 면접과 피드백을 진행합니다.',
      location: '인천',
      time: '매주 목요일, 17:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스터디 그룹 모집'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // 카테고리 타이틀
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '카테고리',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          // 가로 스크롤 카테고리 목록
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${category.name} 카테고리 선택됨'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: 180,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 상단: 아이콘 및 카테고리 제목
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.teal,
                                child: Icon(category.icon, color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // 하위 항목 제목
                          const Text(
                            '하위 항목',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          // 하위 항목 리스트
                          Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: category.subcategories.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 4),
                              itemBuilder: (context, index) {
                                return Text(
                                  category.subcategories[index],
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 모집글 섹션 타이틀
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '스터디 그룹 모집글',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          // 모집글 목록
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: posts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                color: Colors.white,
                surfaceTintColor: Colors.transparent,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 모집글 제목
                      Text(
                        post.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      // 모집글 내용
                      Text(
                        post.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      // 모집글 위치 및 시간 정보
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            post.location,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            post.time,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 지원하기 버튼
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${post.title}에 지원하셨습니다.'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text('지원하기'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
