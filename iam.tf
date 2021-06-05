resource "aws_iam_role" "firehose-stream-role" {
  //
  name = "firehose-stream-role"
  // role = "aws_iam_role.firehose-stream-role.id"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "firehose.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}