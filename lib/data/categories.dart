/// Success : "ok"
/// Data : {"channel_categories":[{"id":433,"title":"资讯台"},{"id":442,"title":"音乐台"},{"id":429,"title":"交通台"},{"id":439,"title":"经济台"},{"id":432,"title":"文艺台"},{"id":441,"title":"都市台"},{"id":430,"title":"体育台"},{"id":431,"title":"双语台"},{"id":440,"title":"综合台"},{"id":438,"title":"生活台"},{"id":435,"title":"旅游台"},{"id":436,"title":"曲艺台"},{"id":434,"title":"方言台"}],"program_categories":[{"id":398,"title":"情感两性","cover":"http://sss.qtfm.cn/hybrid/images/categories/liangxing.jpg"},{"id":400,"title":"小说故事","cover":"http://sss.qtfm.cn/hybrid/images/categories/xiaoshuo.jpg"},{"id":427,"title":"娱乐搞笑","cover":"http://sss.qtfm.cn/hybrid/images/categories/yule.jpg"},{"id":396,"title":"音乐时尚","cover":"http://sss.qtfm.cn/hybrid/images/categories/yinyue.jpg"},{"id":404,"title":"民生热点","cover":"http://sss.qtfm.cn/hybrid/images/categories/minsheng.jpg"},{"id":405,"title":"外语天地","cover":"http://sss.qtfm.cn/hybrid/images/categories/waiyu.jpg"},{"id":470,"title":"粤语专区","cover":"http://sss.qtfm.cn/hybrid/images/categories/yueyu.jpg"},{"id":399,"title":"时事要闻","cover":"http://sss.qtfm.cn/hybrid/images/categories/shishi.jpg"},{"id":406,"title":"汽车交通","cover":"http://sss.qtfm.cn/hybrid/images/categories/jiaotong.jpg"},{"id":397,"title":"品质生活","cover":"http://sss.qtfm.cn/hybrid/images/categories/shenghuo.jpg"},{"id":402,"title":"明星访谈","cover":"http://sss.qtfm.cn/hybrid/images/categories/fangtan.jpg"},{"id":425,"title":"财经股市","cover":"http://sss.qtfm.cn/hybrid/images/categories/caijing.jpg"},{"id":403,"title":"曲艺杂谈","cover":"http://sss.qtfm.cn/hybrid/images/categories/quyuan.jpg"},{"id":401,"title":"新闻评论","cover":"http://sss.qtfm.cn/hybrid/images/categories/xinwen.jpg"},{"id":426,"title":"大话体坛","cover":"http://sss.qtfm.cn/hybrid/images/categories/titan.jpg"}],"regions":[{"id":-1,"title":"省市台"},{"id":407,"title":"网络台"}],"regions_map":[{"id":3,"title":"北京"},{"id":5,"title":"天津"},{"id":7,"title":"河北"},{"id":83,"title":"上海"},{"id":19,"title":"山西"},{"id":31,"title":"内蒙古"},{"id":44,"title":"辽宁"},{"id":59,"title":"吉林"},{"id":69,"title":"黑龙江"},{"id":85,"title":"江苏"},{"id":99,"title":"浙江"},{"id":111,"title":"安徽"},{"id":129,"title":"福建"},{"id":139,"title":"江西"},{"id":151,"title":"山东"},{"id":169,"title":"河南"},{"id":187,"title":"湖北"},{"id":202,"title":"湖南"},{"id":217,"title":"广东"},{"id":239,"title":"广西"},{"id":254,"title":"海南"},{"id":257,"title":"重庆"},{"id":259,"title":"四川"},{"id":281,"title":"贵州"},{"id":291,"title":"云南"},{"id":316,"title":"陕西"},{"id":327,"title":"甘肃"},{"id":351,"title":"宁夏"},{"id":357,"title":"新疆"},{"id":308,"title":"西藏"},{"id":342,"title":"青海"}]}

class Categories {
  Categories({
      String? success, 
      Data? data,}){
    _success = success;
    _data = data;
}

  Categories.fromJson(dynamic json) {
    _success = json['Success'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  String? _success;
  Data? _data;
Categories copyWith({  String? success,
  Data? data,
}) => Categories(  success: success ?? _success,
  data: data ?? _data,
);
  String? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Success'] = _success;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    return map;
  }

}

/// channel_categories : [{"id":433,"title":"资讯台"},{"id":442,"title":"音乐台"},{"id":429,"title":"交通台"},{"id":439,"title":"经济台"},{"id":432,"title":"文艺台"},{"id":441,"title":"都市台"},{"id":430,"title":"体育台"},{"id":431,"title":"双语台"},{"id":440,"title":"综合台"},{"id":438,"title":"生活台"},{"id":435,"title":"旅游台"},{"id":436,"title":"曲艺台"},{"id":434,"title":"方言台"}]
/// program_categories : [{"id":398,"title":"情感两性","cover":"http://sss.qtfm.cn/hybrid/images/categories/liangxing.jpg"},{"id":400,"title":"小说故事","cover":"http://sss.qtfm.cn/hybrid/images/categories/xiaoshuo.jpg"},{"id":427,"title":"娱乐搞笑","cover":"http://sss.qtfm.cn/hybrid/images/categories/yule.jpg"},{"id":396,"title":"音乐时尚","cover":"http://sss.qtfm.cn/hybrid/images/categories/yinyue.jpg"},{"id":404,"title":"民生热点","cover":"http://sss.qtfm.cn/hybrid/images/categories/minsheng.jpg"},{"id":405,"title":"外语天地","cover":"http://sss.qtfm.cn/hybrid/images/categories/waiyu.jpg"},{"id":470,"title":"粤语专区","cover":"http://sss.qtfm.cn/hybrid/images/categories/yueyu.jpg"},{"id":399,"title":"时事要闻","cover":"http://sss.qtfm.cn/hybrid/images/categories/shishi.jpg"},{"id":406,"title":"汽车交通","cover":"http://sss.qtfm.cn/hybrid/images/categories/jiaotong.jpg"},{"id":397,"title":"品质生活","cover":"http://sss.qtfm.cn/hybrid/images/categories/shenghuo.jpg"},{"id":402,"title":"明星访谈","cover":"http://sss.qtfm.cn/hybrid/images/categories/fangtan.jpg"},{"id":425,"title":"财经股市","cover":"http://sss.qtfm.cn/hybrid/images/categories/caijing.jpg"},{"id":403,"title":"曲艺杂谈","cover":"http://sss.qtfm.cn/hybrid/images/categories/quyuan.jpg"},{"id":401,"title":"新闻评论","cover":"http://sss.qtfm.cn/hybrid/images/categories/xinwen.jpg"},{"id":426,"title":"大话体坛","cover":"http://sss.qtfm.cn/hybrid/images/categories/titan.jpg"}]
/// regions : [{"id":-1,"title":"省市台"},{"id":407,"title":"网络台"}]
/// regions_map : [{"id":3,"title":"北京"},{"id":5,"title":"天津"},{"id":7,"title":"河北"},{"id":83,"title":"上海"},{"id":19,"title":"山西"},{"id":31,"title":"内蒙古"},{"id":44,"title":"辽宁"},{"id":59,"title":"吉林"},{"id":69,"title":"黑龙江"},{"id":85,"title":"江苏"},{"id":99,"title":"浙江"},{"id":111,"title":"安徽"},{"id":129,"title":"福建"},{"id":139,"title":"江西"},{"id":151,"title":"山东"},{"id":169,"title":"河南"},{"id":187,"title":"湖北"},{"id":202,"title":"湖南"},{"id":217,"title":"广东"},{"id":239,"title":"广西"},{"id":254,"title":"海南"},{"id":257,"title":"重庆"},{"id":259,"title":"四川"},{"id":281,"title":"贵州"},{"id":291,"title":"云南"},{"id":316,"title":"陕西"},{"id":327,"title":"甘肃"},{"id":351,"title":"宁夏"},{"id":357,"title":"新疆"},{"id":308,"title":"西藏"},{"id":342,"title":"青海"}]

class Data {
  Data({
      List<ChannelCategories>? channelCategories, 
      List<ProgramCategories>? programCategories, 
      List<Regions>? regions, 
      List<RegionsMap>? regionsMap,}){
    _channelCategories = channelCategories;
    _programCategories = programCategories;
    _regions = regions;
    _regionsMap = regionsMap;
}

  Data.fromJson(dynamic json) {
    if (json['channel_categories'] != null) {
      _channelCategories = [];
      json['channel_categories'].forEach((v) {
        _channelCategories?.add(ChannelCategories.fromJson(v));
      });
    }
    if (json['program_categories'] != null) {
      _programCategories = [];
      json['program_categories'].forEach((v) {
        _programCategories?.add(ProgramCategories.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      _regions = [];
      json['regions'].forEach((v) {
        _regions?.add(Regions.fromJson(v));
      });
    }
    if (json['regions_map'] != null) {
      _regionsMap = [];
      json['regions_map'].forEach((v) {
        _regionsMap?.add(RegionsMap.fromJson(v));
      });
    }
  }
  List<ChannelCategories>? _channelCategories;
  List<ProgramCategories>? _programCategories;
  List<Regions>? _regions;
  List<RegionsMap>? _regionsMap;
Data copyWith({  List<ChannelCategories>? channelCategories,
  List<ProgramCategories>? programCategories,
  List<Regions>? regions,
  List<RegionsMap>? regionsMap,
}) => Data(  channelCategories: channelCategories ?? _channelCategories,
  programCategories: programCategories ?? _programCategories,
  regions: regions ?? _regions,
  regionsMap: regionsMap ?? _regionsMap,
);
  List<ChannelCategories>? get channelCategories => _channelCategories;
  List<ProgramCategories>? get programCategories => _programCategories;
  List<Regions>? get regions => _regions;
  List<RegionsMap>? get regionsMap => _regionsMap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_channelCategories != null) {
      map['channel_categories'] = _channelCategories?.map((v) => v.toJson()).toList();
    }
    if (_programCategories != null) {
      map['program_categories'] = _programCategories?.map((v) => v.toJson()).toList();
    }
    if (_regions != null) {
      map['regions'] = _regions?.map((v) => v.toJson()).toList();
    }
    if (_regionsMap != null) {
      map['regions_map'] = _regionsMap?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 3
/// title : "北京"

class RegionsMap {
  RegionsMap({
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  RegionsMap.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;
RegionsMap copyWith({  num? id,
  String? title,
}) => RegionsMap(  id: id ?? _id,
  title: title ?? _title,
);
  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}

/// id : -1
/// title : "省市台"

class Regions {
  Regions({
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Regions.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;
Regions copyWith({  num? id,
  String? title,
}) => Regions(  id: id ?? _id,
  title: title ?? _title,
);
  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}

/// id : 398
/// title : "情感两性"
/// cover : "http://sss.qtfm.cn/hybrid/images/categories/liangxing.jpg"

class ProgramCategories {
  ProgramCategories({
      num? id, 
      String? title, 
      String? cover,}){
    _id = id;
    _title = title;
    _cover = cover;
}

  ProgramCategories.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _cover = json['cover'];
  }
  num? _id;
  String? _title;
  String? _cover;
ProgramCategories copyWith({  num? id,
  String? title,
  String? cover,
}) => ProgramCategories(  id: id ?? _id,
  title: title ?? _title,
  cover: cover ?? _cover,
);
  num? get id => _id;
  String? get title => _title;
  String? get cover => _cover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['cover'] = _cover;
    return map;
  }

}

/// id : 433
/// title : "资讯台"

class ChannelCategories {
  ChannelCategories({
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  ChannelCategories.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;
ChannelCategories copyWith({  num? id,
  String? title,
}) => ChannelCategories(  id: id ?? _id,
  title: title ?? _title,
);
  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}