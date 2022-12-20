resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "ec2-s3-role"
  assume_role_policy = "${file("ec2-role-policy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "s3-read-policy"
  description = "Policy providing read access to demo-bucket bucket"
  policy      = "${file("s3-bucket-read-policy.json")}"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  roles = ["${aws_iam_role.ec2_s3_access_role.name}"]
}
