
## Step-01: Create a new ec2 instance for bastion host

* Install the ec2 instance choosing a public subnet pointing to EKS vpc.

* Create a Security group only allow from My_ip_address

## Step 02:

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

## Step 03: Update kubeconfig

$ kubectl get cm aws-auth -n kube-system -o yaml > aws-auth.yaml		# For backup

$ kubectl edit cm aws-auth -n kube-system

* Add the below lines and make sure that you change your user arn which is present in IAM user section.
* If you have problems then refer the link from aws perspective.
* https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
* Go down and you can see edit ConfigMap manually from there you can get the below file 

$ - groups:
      - system:masters
      userarn: arn:aws:iam::111122223333:user/admin
      username: admin

$ kubectl describe cm aws-auth -n kube-system

$ aws sts get-caller-identity

$ > ~/.aws/config

$ > ~/.aws/credentials

Now check for sts-caller-identity your role arn should be added instead of showing credentials.

$ aws sts get-caller-identity

## Step 04: Install K9s

(For Linux/Mac) Paste this into a Linux shell prompt or terminal, and press enter.

curl -sS https://webi.sh/k9s | sh

(For windows)

curl.exe https://webi.ms/k9s | powershell

Access the pods






