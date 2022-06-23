// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class RentWidget extends StatelessWidget {
  final Color color;
  final String rent;

  const RentWidget({
    Key? key,
    required this.color,
    required this.rent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "Rent - "
              "₹",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
                fontSize: 16,
                fontFeatures: [
                  // const FontFeature.superscripts(),
                  //(this is the function of showing rent as slite upsite for show decimal digit)
                ],
              ),
            ),
            Text(
              rent,
              style:  TextStyle( color: color,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            
            // this is for show the rent in decimal
            
            // Text(
            //   (rent-rent.toInt()).toString(),
            //   style: TextStyle(
            //     color: color,
            //     fontSize: 15, fontWeight: FontWeight.w700,
            // fontFeatures: [
            //   const FontFeature.superscripts(),
            // ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}






class DepWidget extends StatelessWidget {
  final Color color;
  final double dep;

  const DepWidget({
    Key? key,
    required this.color,
    required this.dep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Deposit - "
          "₹",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: color,
            fontSize: 14,
            fontFeatures: [
              // const FontFeature.superscripts(),
              //(this is the function of showing rent as slite upsite for show decimal digit)
            ],
          ),
        ),
        Text(
          dep.toInt().toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // this is for show the rent in decimal

        // Text(
        //   (rent-rent.toInt()).toString(),
        //   style: TextStyle(
        //     color: color,
        //     fontSize: 15, fontWeight: FontWeight.w700,
        // fontFeatures: [
        //   const FontFeature.superscripts(),
        // ],
        //   ),
        // ),
      ],
    );
  }
}



class ContactWidget extends StatelessWidget {
  final Color color;
  final double contact;

  const ContactWidget({
    Key? key,
    required this.color,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Contact- " ,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: color,
            fontSize: 14,
            fontFeatures: [
              // const FontFeature.superscripts(),
              //(this is the function of showing rent as slite upsite for show decimal digit)
            ],
          ),
        ),
        Text(
          contact.toInt().toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // this is for show the rent in decimal

        // Text(
        //   (rent-rent.toInt()).toString(),
        //   style: TextStyle(
        //     color: color,
        //     fontSize: 15, fontWeight: FontWeight.w700,
        // fontFeatures: [
        //   const FontFeature.superscripts(),
        // ],
        //   ),
        // ),
      ],
    );
  }
}
