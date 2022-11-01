import 'dart:math';

// AWS-IOT || MQTT
const String siteid = 'klia-1';
const String region = 'ap-southeast-1';
const String iotApiUrl = 'https://iot.$region.amazonaws.com/target-policies';
const String policyName = 'klia-identity';
// const String userPoolId = 'ap-southeast-1_y6j2hRCPI';
// const String clientId = '1ra3jmjnfteahuje91j2btoj86';

const String userPoolId = 'ap-southeast-1_FBdOBwnLZ';
const String clientId = '6m5009uu7lgi1sk1qv30f146cc';

// String clientId = (Random().nextInt(1000000) * 100000 + 1).floor().toString();
// // String clientId = getRandomString(26);

// const String identityPoolId =
//     'ap-southeast-1:45758fdc-5fcf-4a14-8fd5-e7f0665fd548';

const String identityPoolId =
    'ap-southeast-1:5f1be1d7-f265-48e2-90f7-6d1fc807f607';

const String baseUrl = 'https://smart-track.malaysiaairports.com.my';
// const String baseUrl = '';

// const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
// Random _rnd = Random();

// String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
//     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
