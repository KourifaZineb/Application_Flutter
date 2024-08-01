import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(keyword.isEmpty ? "Search" : keyword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter keyword'),
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
              onSubmitted: (value) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GalleryData(value)));
              },
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GalleryData(keyword)));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.deepOrange,
                ),
                child: Text('Get Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryData extends StatefulWidget {
  final String keyWord;
  GalleryData(this.keyWord);
  @override
  _GalleryDataState createState() => _GalleryDataState();
}

class _GalleryDataState extends State<GalleryData> {
  List<dynamic> hits = [];
  int currentPage = 1;
  int pageSize = 10;
  int totalPages = 0;
  late ScrollController _scrollController;
  dynamic dataGallery;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          ++currentPage;
          loadData();
        }
      }
    });
    loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadData() {
    String url = "https://pixabay.com/api/?key=45226052-48a2cb8633339f3185fcd2cb8&q=${widget.keyWord}&page=$currentPage&per_page=$pageSize";
    print(url);
    getData(url);
  }

  void getData(String url) {
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        dataGallery = json.decode(resp.body);
        hits.addAll(dataGallery['hits']);
        totalPages = (dataGallery['totalHits'] + pageSize - 1) ~/ pageSize;
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.keyWord} : $currentPage / $totalPages'),
        backgroundColor: Colors.deepOrange,
      ),
      body: dataGallery == null ? Center(child: CircularProgressIndicator()) : ListView.builder(
        controller: _scrollController,
        itemCount: hits.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Card(
                color: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    hits[index]['tags'],
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                child: Image.network(hits[index]['previewURL'], fit: BoxFit.fitWidth),
              ),
              Divider(color: Colors.grey, thickness: 2),
            ],
          );
        },
      ),
    );
  }
}
