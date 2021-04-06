import 'package:flutter/material.dart';

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "Get inspiration from user generated location-based personalized food content");
  sliderModel.setTitle("Search");
  sliderModel.setImageAssetPath("assets/images/intro1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "More product visualization \n to make easier decision \n for purchasing the product");
  sliderModel.setTitle("Order");
  sliderModel.setImageAssetPath("assets/images/intro2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Earn rewards for \n sharing video content");
  sliderModel.setTitle("Eat");
  sliderModel.setImageAssetPath("assets/images/intro3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //4
  sliderModel.setDesc(
      "New experience to order a product, book a restaurant \n or prepare your own food \n from shared video content");
  sliderModel.setTitle("Eat");
  sliderModel.setImageAssetPath("assets/images/intro4.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //5
  sliderModel.setDesc("Build your audience by \n getting more followers  ");
  sliderModel.setTitle("Eat");
  sliderModel.setImageAssetPath("assets/images/intro5.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //6
  sliderModel.setDesc(
      "Everything about food \n at one place: promotion, \n articles news, and \n entertainment");
  sliderModel.setTitle("Eat");
  sliderModel.setImageAssetPath("assets/images/intro6.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
