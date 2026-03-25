const AWS = require("aws-sdk");
const crypto = require("crypto");


const dynamodb = new AWS.DynamoDB.DocumentClient();

const TABLE_NAME = process.env.TABLE_NAME;

exports.handler = async () => {

  // クエリパラメータを取得
  const saveText = event.queryStringParameters?.q ?? "";

  const params = {
    TableName: TABLE_NAME,
    Item: {
      paymentId: crypto.randomUUID(),
      encrypted_value: saveText  // ← フロントから受け取った値を保存
    }
  };

  await dynamodb.put(params).promise();

  return {
    statusCode: 200,
    body: JSON.stringify("saved"),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Content-Type",
      "Access-Control-Allow-Methods": "GET"
  } ,
  };
};