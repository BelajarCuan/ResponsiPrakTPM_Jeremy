import 'package:flutter/material.dart';
import 'package:responsi/list_news_model.dart';
import 'package:responsi/api_data_source.dart';
import 'package:responsi/page_detail_internasional.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetailTerbaru extends StatefulWidget {
  final String link;
  const PageDetailTerbaru({Key? key, required this.link}) : super(key: key);

  @override
  State<PageDetailTerbaru> createState() => _PageDetailTerbaruState();
}

class _PageDetailTerbaruState extends State<PageDetailTerbaru> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPUBLIKA News"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 23, 120, 134), // Change the background color here
      ),
      body: _buildDetailTerbaru(),
    );
  }

  Widget _buildDetailTerbaru() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadTerbaru(),
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
        ? Container(
            child: Column(
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
                InkWell(
                  onTap: () => launchUrl(Uri.parse(postingan.link!)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green, // Warna latar belakang hijau
                      borderRadius: BorderRadius.circular(8.0), // Sudut border bulat
                    ),
                    padding: EdgeInsets.all(12.0), // Padding di dalam kontainer
                    child: Text(
                      'Baca Selengkapnya...',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontWeight: FontWeight.bold, // Teks tebal
                        fontSize: 16.0, // Ukuran teks
                      ),
                    ),
                  ),
                )

              ],
            ),
          )
        : SizedBox();
  }
}


  Widget _buildItemTerbaru(Posts postingan, String link) {
  return (link == postingan.link!)
      ? Align(
    alignment: Alignment.bottomRight,
    child: Container(
      child: Column(
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
          InkWell(
            onTap: () => launchUrl(Uri.parse(postingan.link!)),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 120, 134), // Warna latar belakang hijau
                borderRadius: BorderRadius.circular(8.0), // Sudut border bulat
              ),
              padding: EdgeInsets.all(12.0), // Padding di dalam kontainer
              child: Text(
                'Baca Selengkapnya...',
                style: TextStyle(
                  color: Colors.white, // Warna teks putih
                  fontWeight: FontWeight.bold, // Teks tebal
                  fontSize: 16.0, // Ukuran teks
                ),
              ),
            ),
          )
        ],
      ),
    ),
  )
      : SizedBox();
}

