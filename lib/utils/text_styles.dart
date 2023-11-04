import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///[Textstyles] for each Text as needed.
///the app has as based the [GoogleFonts] type: [inder]
///
extension HomePageTitleStyle on Text {
  Text homePageTitleStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 55, fontWeight: FontWeight.w500));
  }
}

extension PageTitleStyle on Text {
  Text pageTitleStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600));
  }
}

extension BySearchPageStyle on Text {
  Text bySearchPageStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600));
  }
}

extension CarrouselTitleTextStyle on Text {
  Text carrouselTitleTextStyle() {
    bool newFontSize = false;

    if (data! == 'New\nReleases' || data! == 'Free\nBooks') {
      newFontSize = true;
    }
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: newFontSize ? 30 : 35));
  }
}

extension CarrouselButtonTextStyle on Text {
  Text carrouselButtonTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(color: Colors.white, fontSize: 15));
  }
}

extension NewReleasesButtonTextStyle on Text {
  Text newReleasesButtonTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(color: Colors.white, fontSize: 20));
  }
}

extension ContinueReadingTextStyle on Text {
  Text continueReadingTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(color: Colors.black, fontSize: 13));
  }
}

extension BookRecommendationTextStyle on Text {
  Text bookRecommendationTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600));
  }
}

extension NoConnectionInternetTextStyle on Text {
  Text noConnectionInternetTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400));
  }
}

extension OpenDialogtTextStyle on Text {
  Text openDialogtTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300));
  }
}

extension NavigationBarTextStyle on Text {
  Text navigationBarTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600));
  }
}

extension BookResultsCardTextStyle on Text {
  Text bookResultsCardTextStyle() {
    return Text(data!,
        style: GoogleFonts.inder(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500));
  }
}
