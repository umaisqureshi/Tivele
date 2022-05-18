class ProductAttributes{
  String attributeName;
  var attributeValues = List();
  ProductAttributes(this.attributeName,this.attributeValues);
  Map toJson() => {
    'attribute_name': attributeName,
    'attribute_values': attributeValues,
  };
}
class AttributeValues{
  String attributeValue;
  AttributeValues(this.attributeValue);
}