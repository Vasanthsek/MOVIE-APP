// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

import '../description.dart';

class Tvv extends StatelessWidget {
  final List tv;
  const Tvv({Key? key,required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const ModifiedText(text: "Popular Tv Shows", color: Colors.white, size: 26),
           const SizedBox(height: 10,),
           Container(height: 200,child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tv.length,
            itemBuilder: (context, index) {
              final String? image = tv[index]['backdrop_path'];
              final String? texxt = tv[index]["original_name"];
              final String? imagee = tv[index]["backdrop_path"];
              final String? imageee = tv[index]["poster_path"];
              final String backdrop = 'https://image.tmdb.org/t/p/w500$imagee';
              final String posterurl = 'https://image.tmdb.org/t/p/w500$imageee';
              final String? description = tv[index]["overview"];
              final String vote = tv[index]["vote_average"].toString();
              // final String round = vote.substring(0,2);
              // final String launch_on = tv[index]["release_date"];
              // print(texxt);
              // print(image);
              return InkWell(
               onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Description(name: texxt!, description: description!, bannerurl: backdrop, posterurl: posterurl, vote: vote, launch_on: tv[index]["first_air_date"] ?? ""),));
               },
               child:texxt != null?
                Container(
                padding: const EdgeInsets.all(5),
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(image != null)
                    Container(
                      height: 140,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(

                          'https://image.tmdb.org/t/p/w500$image'),fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10,),
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