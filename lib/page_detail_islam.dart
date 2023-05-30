import 'package:flutter/material.dart';
import 'package:responsi/list_news_model.dart';
import 'package:responsi/api_data_source.dart';
import 'package:responsi/page_detail_internasional.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetailIslam extends StatefulWidget {
  final String link;
  const PageDetailIslam({Key? key, required this.link}) : super(key: key);

  @override
  State<PageDetailIslam> createState() => _PageDetailIslamState();
}

class _PageDetailIslamState extends State<PageDetailIslam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 23, 120, 134),
      ),
      body: _buildDetailIslam(),
    );
  }

  Widget _buildDetailIslam() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadIslam(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            ListNewsModel listNewsModel = ListNewsModel.fromJson(snapshot.data);
            return _buildSuccessSection(listNewsModel, widget.link);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(ListNewsModel data, String link) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.data!.posts!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemTerbaru(data.data!.posts![index], link);
      },
    );
  }

  Widget _buildItemTerbaru(Posts postingan, String link) {
    return (link == postingan.link!)
        ? Stack(
      children: [
        Column(
          children: [
            Text(
              postingan.title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(postingan.pubDate!),
            Image.network(postingan.thumbnail!),
            Text(postingan.description!),
          ],
        ),
        Positioned(
          bottom: 2.0, // Distance from the bottom
          right: 16.0, // Distance from the right

          child: InkWell(
            onTap: () => launchUrl(Uri.parse(postingan.link!)),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 120, 134), // Background color green
                borderRadius: BorderRadius.circular(8.0), // Rounded border corners
              ),

              padding: EdgeInsets.all(12.0), // Padding inside the container
              child: Text(
                'Baca Selengkapnya...',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold, // Bold text
                  fontSize: 16.0, // Text size
                ),
              ),
            ),
          ),
        ),
      ],
    )
        : SizedBox();
  }

}
