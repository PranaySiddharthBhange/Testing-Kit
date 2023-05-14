library globals.dart;

import 'dart:math';


var selectedSoil = 'Black Soil';
var selectedCrop;

String forBlack = 'Cotton';
String forAlluvial ='Cotton';
String forRedYellow='Ground Nut';
String forLaterite ='Cotton';
String forArid='Wheat';

// List of items in our soils
var Soils = [
  'Black Soil',
  'Alluvial Soil',
  'Laterite Soil',
  'Arid Soil',
];

// List of items for black soil
var forBlackList = [
  'Rice',
  'Wheat',
  'Pulses',
  'Soyabean',
  'Cereals',
  'Sugar Cane',
  'Cotton',
  'Potato'
  'Termeric'
];
var forAlluvialList = [
  'Cotton',
  'Wheat',
  'Bajra',
  'Jute',
  'Maize',
];
var forLateriteList = [
  'Cotton',
  'Wheat',
  'Rice',
  'Cashews',
  'Coffee',
];
var forAridList = [
  'Wheat',
  'Barley',
  'Maize',
  'Spices',
  'Coffee',
];
//Random
var randomTemperature;
var randomHumidity;
var randomMoisture;
var randomPhosphorus;
var randomNitrogen;
var randomPotassium;
var randomWaterReq;

