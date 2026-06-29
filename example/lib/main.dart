import 'package:flutter/material.dart';
import 'package:lurp/lurp.dart';

void main() {
  // Initialize Lurp configurations
  Lurp.initialize(apiKey: 'example-api-key', isProd: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lurp Widget Example',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
          brightness: Brightness.dark,
        ),
      ),
      home: const ExampleHomeScreen(),
    );
  }
}

class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({super.key});

  @override
  State<ExampleHomeScreen> createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _postIdController = TextEditingController(
    text: 'eLXplNKyfrb',
  );

  // List of mock posts to render directly using Lurp
  late final List<LurpPost> _mockPosts;

  @override
  void initState() {
    super.initState();
    final mockCreator = LurpUser(
      uid: 'user-123',
      username: 'LurpDeveloper',
      flatUsername: 'lurpdeveloper',
      rank: 'Pro Creator',
    );

    _mockPosts = [
      // 1. Selection Poll
      LurpPost(
        id: 'poll-selection',
        type: 'selection',
        state: 'visible',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        commentCount: 42,
        upvoteCount: 156,
        downvoteCount: 3,
        creator: mockCreator,
        topComments: [],
        media: [],
        siuRating: '',
        selection: SelectionPoll(
          title: 'What is your favorite Flutter state management solution?',
          options: [
            PollOption(key: 'bloc', text: 'Bloc / Cubit', voteCount: 450),
            PollOption(key: 'provider', text: 'Provider', voteCount: 220),
            PollOption(key: 'riverpod', text: 'Riverpod', voteCount: 510),
            PollOption(
              key: 'signals',
              text: 'Signals / GetX / MobX',
              voteCount: 95,
            ),
          ],
          siuVote: null,
          voteCount: 1275,
        ),
      ),

      // 2. Slider Poll
      LurpPost(
        id: 'poll-slider',
        type: 'slider',
        state: 'visible',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        commentCount: 18,
        upvoteCount: 89,
        downvoteCount: 1,
        creator: mockCreator,
        topComments: [],
        media: [],
        siuRating: '',
        slider: SliderPoll(
          title: 'Rate the developer experience of Flutter 3.x (0 to 10):',
          siuVote: null,
          averageValue: 0.87, // 8.7 out of 10
          voteCount: 320,
          votes: [0.8, 0.9, 1.0, 0.8],
          valueStart: 0.0,
          valueEnd: 10.0,
          valueSegments: 10,
        ),
      ),

      // 3. Rating Poll
      LurpPost(
        id: 'poll-rating',
        type: 'rating',
        state: 'visible',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        commentCount: 9,
        upvoteCount: 47,
        downvoteCount: 0,
        creator: mockCreator,
        topComments: [],
        media: [],
        siuRating: '',
        rating: RatingPoll(
          title: 'How would you rate the performance of compiled Flutter apps?',
          siuVote: null,
          averageValue: 4.3,
          voteCount: 85,
          starCount: 5,
        ),
      ),

      // 4. Thought Post
      LurpPost(
        id: 'thought-post',
        type: 'thought',
        state: 'visible',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
        commentCount: 5,
        upvoteCount: 23,
        downvoteCount: 1,
        creator: mockCreator,
        topComments: [],
        media: [],
        siuRating: '',
        thought: ThoughtPost(
          text:
              'Flutter is extremely powerful for building beautiful desktop and web apps besides mobile. Creating custom packages like this simplifies building modular architectures for larger applications!',
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lurp Widget Demo'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tab buttons to toggle mock posts
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTabButton(0, 'Selection'),
                      _buildTabButton(1, 'Slider'),
                      _buildTabButton(2, 'Rating'),
                      _buildTabButton(3, 'Thought'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Mock Widget Preview
              Text(
                'Mock Widget Preview (Offline)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Lurp(
                post: _mockPosts[_currentIndex],
                onCreatorTap: (creator) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped creator: ${creator.username}'),
                    ),
                  );
                },
                onShareTap: (post) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sharing URL: ${post.fullUrl}')),
                  );
                },
              ),
              const SizedBox(height: 40),

              const Divider(),
              const SizedBox(height: 20),

              // Live Widget Load section
              Text(
                'Live Widget Preview (Requires backend / apiKey)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _postIdController,
                        decoration: const InputDecoration(
                          labelText: 'Post ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text('Load Live Lurp'),
                        onPressed: () {
                          final id = _postIdController.text.trim();
                          if (id.isEmpty) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(title: Text('Live Post: $id')),
                                body: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SingleChildScrollView(
                                    child: Lurp.network(postId: id),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _currentIndex == index;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
    );
  }
}
