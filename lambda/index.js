const AWS = require("aws-sdk");
const { v4: uuidv4 } = require("uuid");

const dynamodb = new AWS.DynamoDB.DocumentClient();

const TABLE_NAME = process.env.TABLE_NAME;

exports.handler = async () => {

  const params = {
    TableName: TABLE_NAME,
    Item: {
      paymentId: uuidv4(),
      encrypted_value: "test-data"
    }
  };

  await dynamodb.put(params).promise();

  return {
    statusCode: 200,
    body: JSON.stringify("saved")
  };
};