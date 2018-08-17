let
  region = "ap-southeast-1";
  accessKeyId = "dev";

  ec2 =
    { resources, ... }:
    { deployment.targetEnv = "ec2";
      deployment.ec2.accessKeyId = accessKeyId;
      deployment.ec2.region = region;
      deployment.ec2.instanceType = "t2.micro";
      deployment.ec2.keyPair = resources.ec2KeyPairs.qoeifs-keys;
      #deployment.ec2.privateKey = "/home/rizilab/Downloads/qoeifs.pem";
      deployment.ec2.securityGroups = [ "allowSSH" "allowHTTP" ];
    };

in
{
  qoeifs = ec2;
  resources.ec2KeyPairs.qoeifs-keys =
    { inherit region accessKeyId; };
}