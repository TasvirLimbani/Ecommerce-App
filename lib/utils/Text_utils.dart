import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextUtils {
  Text normal11(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.normal),
    );
  }

  Text normal12(String text, Color color) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style:
          TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.normal),
    );
  }

  Text normal10(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.normal),
    );
  }

  Text normal8(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.normal),
    );
  }

  Text normal14(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.normal),
    );
  }

  Text normal14Ellipsis(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis),
    );
  }

  Text bold16Ellipsis(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }

  Text normal16(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.normal),
    );
  }

  Text normal17(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 17, fontWeight: FontWeight.normal),
    );
  }

  Text normal18(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.normal),
    );
  }

  Text normal20(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.normal),
    );
  }

  Text bold10(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
    );
  }

  Text bold12(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
  Text bold12over(String text, Color color) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }

  Text bold12throw(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough),
    );
  }

  Text bold20throw(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough),
    );
  }

  Text bold14(String text, Color color, {TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Text bold14over(String text, Color color, {TextAlign? textAlign}) {
    return Text(
      text,
      // textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Text bold14line(
    String text,
    Color color,
  ) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w900,
          fontFamily: GoogleFonts.poppins().fontFamily),
    );
  }

  Text bold13(
    String text,
    Color color,
  ) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text bold13tho(
    String text,
    Color color,
  ) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough),
    );
  }

  Text bold16(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Text bold16max(String text, Color color) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Text bold16Center(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Text bold18(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Text bold18Over(String text, Color color) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Text bold20(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Text bold25(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Text bold30(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Text bold35(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}
