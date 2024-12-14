import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this package to open links

class MovieDetailsScreen extends StatelessWidget {
  final movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final show = movie.show;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          show.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                show.image.medium.isNotEmpty
                    ? show.image.medium
                    : 'https://upload.wikimedia.org/wikipedia/commons/d/dc/No_Preview_image_2.png',
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              show.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),

            Text(
              'Premiered: ${show.premiered}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),

            Text(
              'Rating: ${show.rating.average}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),

            Text(
              'Genres: ${show.genres.join(', ')}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),

            Text(
              'Runtime: ${show.runtime} min',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),

            Text(
              'Summary:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              show.summary.replaceAll(RegExp(r'<[^>]*>'), ''),
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 16),

            Text(
              'Network: ${show.network.name}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: () {
                launchURL(show.officialSite);
              },
              child: Text(
                'Official Website: ${show.officialSite}',
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),

            if (show._links != null) ...[
              if (show._links['previousepisode'] != null) ...[
                TextButton(
                  onPressed: () {
                    launchURL(show._links['previousepisode']['href']);
                  },
                  child: Text(
                    'Previous Episode: ${show._links['previousepisode']['name']}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
              if (show._links['nextepisode'] != null) ...[
                TextButton(
                  onPressed: () {
                    launchURL(show._links['nextepisode']['href']);
                  },
                  child: Text(
                    'Next Episode: ${show._links['nextepisode']['name']}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
