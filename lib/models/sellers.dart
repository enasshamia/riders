class Sellers
{
  String ? sellerName ;
  String ? sellerUid ;
  String ? sellerAvatrUrl ;
  String ? sellerEmail ;
  String ? info ;

  Sellers({
    this.sellerUid,
    this.sellerName,
    this.sellerAvatrUrl,
    this.sellerEmail,
    this.info,

  });

  Sellers.fromJson(Map<String , dynamic> json){
    sellerUid = json["sellerUID"];
    sellerName = json["sellerName"];
    sellerAvatrUrl = json["sellerAvatrUrl"];
    sellerEmail = json["sellerEmail"];
    info = json["info"];
  }

  Map<String ,dynamic> toJson()
  {
    final Map<String , dynamic> data = new Map<String , dynamic>();
    data["sellerUID"] = this.sellerUid;
    data["sellerName"] = this.sellerName;
    data["sellerAvatrUrl"] = this.sellerAvatrUrl;
    data["sellerEmail"] = this.sellerEmail;
    data["info"] = this.info;
    return data;
  }

}

