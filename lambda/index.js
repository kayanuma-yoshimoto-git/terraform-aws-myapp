const AWS = require("aws-sdk");

const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async () => {

  const params = {
    TableName: "encrypted-data",
    Item: {
      id: "1",
      encrypted_value: "test-data"
    }
  };

  await dynamodb.put(params).promise();

  return {
    statusCode: 200,
    body: JSON.stringify("saved")
  };
};