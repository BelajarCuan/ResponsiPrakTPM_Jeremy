import 'package:flutter/material.dart';
import 'package:responsi/list_news_model.dart';
import 'package:responsi/api_data_source.dart';
import 'package:responsi/page_detail_internasional.dart';

class PageListInternasional extends StatefulWidget {
  const PageListInternasional({Key? key}) : super(key: key);

  @override
  State<PageListInternasional> createState() => _PageListInternasionalState();
}

class _PageListInternasionalState extends State<PageListInternasional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPUBLIK INTERNASIONAL"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 23, 120, 134),
      ),
      body: _buildListNasional(),
    );
  }

  Widget _buildListNasional() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadInternasional(),
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
          builder: (context) => PageDetailnnternasional(
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
