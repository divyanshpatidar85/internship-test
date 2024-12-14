import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/api.dart';
import 'package:quadb_tech/model.dart' as model;
// import 'package:url_launcher/url_launcher.dart';

class NetflixContainer extends StatefulWidget {
  const NetflixContainer({super.key});

  @override
  State<NetflixContainer> createState() => _NetflixContainerState();
}

class _NetflixContainerState extends State<NetflixContainer> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var apiData = Provider.of<ApiData>(context, listen: false);
    await apiData.fetchTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'QuadB',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ApiData>(
        builder: (context, provider, child) {
          if (provider.data.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _buildSectionTitle("Trending Now"),
                _buildTrendingMovies(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTrendingMovies(ApiData provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.61,
      ),
      itemCount: provider.data.length,
      itemBuilder: (context, index) {
        var movie = provider.data[index];

        return GestureDetector(
          onTap: () {
            // Navigate to the details screen with the movie's data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movie: movie),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.3)), // Adding border
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    movie.show.image.medium.isNotEmpty
                        ? movie.show.image.medium
                        : 'https://upload.wikimedia.org/wikipedia/commons/d/dc/No_Preview_image_2.png',
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.show.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  movie.show.premiered,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.yellow[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Rating: ${movie.show.rating.average.toString()}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
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



class MovieDetailsScreen extends StatelessWidget {
  final model.TvShowResponse movie;

  MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  // Function to launch the URL in the browser
  void launchURL(String url) async {
    if (true) {
      // await launch(url);  // Launch the URL
    } else {
      throw 'Could not launch $url';  // Handle error if URL can't be launched
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          movie.show.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),  // Back to the previous screen
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie.show.image.medium.isNotEmpty
                      ? movie.show.image.medium
                      : 'https://upload.wikimedia.org/wikipedia/commons/d/dc/No_Preview_image_2.png',
                  fit: BoxFit.contain,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.show.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                movie.show.language,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Premiered: ${movie.show.premiered}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Rating: ${movie.show.rating.average.toString()}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Text(
                'Genres: ${movie.show.genres.join(', ')}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Text(
                movie.show.summary.replaceAll(RegExp(r'<[^>]*>'), ''), // Remove HTML tags from summary
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Text(
                'Network: ${movie.show.network.name}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              if (movie.show.officialSite.isNotEmpty) ...[
                GestureDetector(
                  onTap: () {
                    // Call launchURL function when tapped
                    launchURL(movie.show.officialSite);
                  },
                  child: Text(
                    'Official Website: ${movie.show.officialSite}',
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
