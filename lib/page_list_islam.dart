import 'package:flutter/material.dart';
import 'package:responsi/list_news_model.dart';
import 'package:responsi/api_data_source.dart';
import 'package:responsi/page_detail_islam.dart';

class PageListIslam extends StatefulWidget {
  const PageListIslam({Key? key}) : super(key: key);

  @override
  State<PageListIslam> createState() => _PageListIslamState();
}

class _PageListIslamState extends State<PageListIslam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPUBLIKA ISLAM"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 23, 120, 134),
      ),
      body: _buildListTeknologi(),
    );
  }

  Widget _buildListTeknologi() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadIslam(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            ListNewsModel listNewsModel = ListNewsModel.fromJson(snapshot.data);
            return _buildSuccessSection(listNewsModel);
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

  Widget _buildSuccessSection(ListNewsModel data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.data!.posts!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemTerbaru(data.data!.posts![index]);
      },
    );
  }

  Widget _buildItemTerbaru(Posts postingan) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageDetailIslam(
            link: postingan.link!,
          ),
        ),
      ),
      child: Card(
        child: ListTile(
          leading: Image.network(postingan.thumbnail!),
          title: Text(postingan.title!),
        ),
      ),
    );
  }
}
