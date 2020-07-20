import 'dart:convert';
//============================  USER =============================================
List<Invoice> invoiceFromJson(String str) => new List<Invoice>.from(json.decode(str).map((x) => Invoice.fromJson(x)));

String invoiceToJson(List<Invoice> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

//==================USERS=============================================
InvoicesList invoicesListFromJson(String str) =>
    InvoicesList.fromJson(json.decode(str));

String invoicesListToJson(InvoicesList invoices) => json.encode(invoices.toJson());

class InvoicesList {
  List<Invoice> invoices;

  InvoicesList({
    this.invoices,
  });

  factory InvoicesList.fromJson(Map<String, dynamic> json) => new InvoicesList(
    invoices:
    new List<Invoice>.from(json["data"].map((x) => Invoice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "invoices": new List<dynamic>.from(invoices.map((x) => x.toJson())),
  };
}


class Invoice{
  final int id;
  final String invoiceId;
  final int userId;
  final String name;
  final String userRefNumber;
  final String description;
  final String userName;
  final String usagePrice;
  final String dateOfInvoice;
  final String lastDateOfInvoice;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    this.id,
    this.invoiceId,
    this.userId,
    this.name,
    this.userRefNumber,
    this.description,
    this.userName,
    this.usagePrice,
    this.dateOfInvoice,
    this.lastDateOfInvoice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });



  factory Invoice.fromJson(Map<String, dynamic> json) => new Invoice(
    id: json["id"] as int,
    invoiceId: json["invoice_id"],
    userId: int.parse(json["user_id"].toString()),
    name: json["name"],
    userRefNumber: json["user_ref_number"],
    description: json["description"],
    userName: json["user_name"],
    usagePrice: json["price"],
    dateOfInvoice: json["date_of_invoice"],
    lastDateOfInvoice: json["last_date_of_invoice"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  //===================== TO JSON =================================
  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_id": invoiceId,
    "user_id": userId,
    "name": name,
    "user_ref_number": userRefNumber,
    "description": description,
    "user_name": userName,
    "price": usagePrice,
    "date_of_invoice": dateOfInvoice,
    "last_date_of_invoice": lastDateOfInvoice,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  //===================== TO MAP =================================
  Map<String, dynamic> toMap() => {
    "id": id,
    "invoice_id": invoiceId,
    "user_id": userId,
    "name": name,
    "user_ref_number": userRefNumber,
    "description": description,
    "user_name": userName,
    "price": usagePrice,
    "date_of_invoice": dateOfInvoice,
    "last_date_of_invoice": lastDateOfInvoice,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

}