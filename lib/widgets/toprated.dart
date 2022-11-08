// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

import '../description.dart';

class TopRated extends StatelessWidget {
  final List toprated;
  const TopRated({Key? key,required this.toprated}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const ModifiedText(text: "Top Rated Movies", color: Colors.white, size: 26),
           const SizedBox(height: 10,),
           Container(height: 270,child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: toprated.length,
            itemBuilder: (context, index) {
              final String? image = toprated[index]['poster_path'];
              final String? texxt = toprated[index]["title"];
              final String? imagee = toprated[index]["backdrop_path"];
              final String? imageee = toprated[index]["poster_path"];
              final String backdrop = 'https://image.tmdb.org/t/p/w500$imagee';
              final String posterurl = 'https://image.tmdb.org/t/p/w500$imageee';
              final String? description = toprated[index]["overview"];
              final String vote = toprated[index]["vote_average"].toString();
              // final String round = vote.substring(0,2);
              final String? launch_on = toprated[index]["release_date"];
              // print(texxt);
              // print(image);
              return InkWell(
               onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Description(name: toprated[index]["title"], description: description!, bannerurl: backdrop, posterurl: posterurl, vote: vote, launch_on: launch_on!),));
               },
               child: texxt != null? 
               Container(
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(image != null)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(

                          'https://image.tmdb.org/t/p/w500$image')),
                      ),
                    ),
                    if(texxt != null)
                    Container(
                      child: ModifiedText(text: texxt,color: Colors.white,size: 13.5),
                    ),
                    // if(image== null||texxt == null )
                    // const Center(child: ModifiedText(text: "Loading", color: Colors.white, size: 13.5)),
                    
                  ], 
                ),
               ):Container(),
              );
            },),
            )
        ],
      ),
    );
  }
}