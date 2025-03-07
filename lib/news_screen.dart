import 'package:blott/bloc/fetch_news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  final String firstName;
  const NewsScreen({super.key, required this.firstName});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    context.read<FetchNewsBloc>().add(FetchNews());
    super.initState();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color(0xFF05021B),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Hey ${widget.firstName}',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 32,
                fontFamily: 'Raleway',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<FetchNewsBloc, FetchNewsState>(
        builder: (context, state) {
          if (state is FetchNewsLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is FetchNewsLoaded) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final news = state.news[index];

                return GestureDetector(
                  onTap: () => _launchURL(news['url']),
                  child: ListTile(
                    leading:
                        news['image'] != null && news['image'].isNotEmpty
                            ? Image.network(
                              news['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                            : SizedBox(
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            ),
                    title: Row(
                      children: [
                        Text(
                          news['source'],
                          style: TextStyle(
                            color: Color(0xFFFFFFB2),
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Text(
                          news['datetime'].toString(),
                          style: TextStyle(
                            color: Color(0xFFFFFFB2),
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      news['headline'],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is FetchNewsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
