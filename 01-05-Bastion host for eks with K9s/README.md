
## Step-01: Create a new ec2 instance for bastion host

* Install the ec2 instance choosing a public subnet pointing to EKS vpc.

* Create a Security group only allow from My_ip_address

## Step 02:
```
* Install Aws CLI

$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

$ Aws configure

* Give your aws user credentials

Install kubectl CLI

* https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

Verify the kubectl client version

$ kubectl version --short --client

$ kubectl version --client

## Next Update the kubeconfig file with your eks-demo-cluster via below command.

$ aws eks update-kubeconfig --region us-east-1 --name eks-demo-cluster

```
## Step 03: Two Options we have one via Aws user And one via Aws eks role policy to access the cluster. Below is via Aws user credentials !
```
## After provisioning the bastion host we need to update the kubeconfig file to access the cluster.

## We have two options one is via user and other is via eks role based permission below is via IAM user.

## Install kubectl command line first from below aws documetation

https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

via user below :

$ aws configure -----------------------> which user created the eks cluster that user's credentials should be given

$ aws eks update-kubeconfig --region us-east-1 --name eks-demo-cluster

If you run the above command for updating kubeconfig context path it will be added for another cluster

$ kubectl cluster info

if still you are not able to access the cluster you need to add 443 port to the security group of the eks cluster

Click on Eks cluster --> Open Networking tab --> Open Cluster security group --> Inbound rules --> add rule 443 --> in source add jump server security group
```
## Step 04 - ####### Role access for eks cluster from bastion host. Below is via Aws Role Policy !
```
Now create a IAM ec2 service empty role (Eks-jump-server-role) without policy added and add it to the EC2 jump server
Next edit the kubectl using below commands to add

$ kubectl get cm aws-auth -n kube-system -o yaml > aws-auth.yaml		# For backup

$ kubectl edit cm aws-auth -n kube-system

* Add the below lines and make sure that you change your user arn which is present in IAM user section.
* If you have problems then refer the link from aws perspective.
* https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
* Go down and you can see edit ConfigMap manually from there you can get the below file 
* Add the Eks-jump-server-role arn & username.

$ - groups:
      - system:masters
      userarn: arn:aws:iam::111122223333:user/admin
      username: Eks-jump-server-role

$ kubectl describe cm aws-auth -n kube-system

$ aws sts get-caller-identity

$ > ~/.aws/config

$ > ~/.aws/credentials

Now check for sts-caller-identity your role arn should be added instead of showing credentials.

$ aws sts get-caller-identity

```
## Step 05: Install K9s
```
(For Linux/Mac) Paste this into a Linux shell prompt or terminal, and press enter.

curl -sS https://webi.sh/k9s | sh

(For windows)

curl.exe https://webi.ms/k9s | powershell

Access the pods
```





