provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

resource "aws_kinesis_stream" "kinesis_stream" {
  name             = "${var.app_name}-kinesis-Data"
  shard_count      = "${var.shard_count}"
  retention_period = "${var.retention_period}"

  shard_level_metrics = "${var.shard_level_metrics}"

  tags = {
    owner = "${var.app_name}"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "firehose-stream-new" {
  //A name to identify the stream
  name        = "firehose-stream-new"
  //This is the destination to where the data is delivered
  destination = "s3"

    s3_configuration {
    //The ARN of the AWS credentials.
    role_arn   = "${aws_iam_role.firehose-stream-role.arn}"
    //The ARN of the S3 bucket
    bucket_arn = "${aws_s3_bucket.s3-new-buck-1.arn}"
    //Buffer incoming data to the specified size, in MBs, before delivering it to the destination.
    buffer_size = 10
    //Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination.
    buffer_interval = 400
    //The compression format
    compression_format = "ZIP"
  }
     
    kinesis_source_configuration {
     role_arn   = "${aws_iam_role.firehose-stream-role.arn}"
    //The ARN of the kinesis stream
    kinesis_stream_arn = "${aws_kinesis_stream.kineis_stream.arn}"
  }
}


resource "aws_s3_bucket" "s3-new-buck-1" {
  //
  bucket = "s3-new-buck-1"
  //Access Connect List
  acl    = "private"
}
