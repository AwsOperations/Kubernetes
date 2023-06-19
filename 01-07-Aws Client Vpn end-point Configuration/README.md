
## Aws client Vpn endpoint Configuration
```
Prerequisite

VPC with at least a private and public subnet
Permissions to create Client VPN
A privately hosted RDS or an EC2 to check and verify the connection
Permissions to import certificates into AWS Certificate Manager.
```
## Step 1: Generate server and client certificates and keys
```
We need to generate server and client certificates first. So to generate the server and client certificates follow the following steps

1. Clone the OpenVPN easy-rsa repo to your local computer and navigate to the easy-rsa/easyrsa3 folder.

$ git clone https://github.com/OpenVPN/easy-rsa.git
$ cd easy-rsa/easyrsa3

2. Initialize a new PKI environment.

$ ./easyrsa init-pki

3. To build a new certificate authority (CA), run this command and follow the prompts.

$ ./easyrsa build-ca nopass

4. Generate the server certificate and key.

$ ./easyrsa build-server-full server nopass

5. Generate the client certificate and key. Make sure to save the client certificate and the client private key because you will need them when you configure the client. And You can optionally repeat this step for each client (end user) that requires a client certificate and key.

$ ./easyrsa build-client-full client1.domain.tld nopass

6. Copy the server certificate and key and the client certificate and key to a custom folder and then navigate into the custom folder. Before you copy the certificates and keys, create the custom folder by using the mkdir command. The following example creates an awsclientvpn directory in your home directory.

$ mkdir ~/awsclientvpn/
$ cp pki/ca.crt ~/awsclientvpn/
$ cp pki/issued/server.crt ~/awsclientvpn/
$ cp pki/private/server.key ~/awsclientvpn/
$ cp pki/issued/client1.domain.tld.crt ~/awsclientvpn
$ cp pki/private/client1.domain.tld.key ~/awsclientvpn/
$ cd ~/awsclientvpn/

7. Upload the server certificate and key and the client certificate and key to ACM. Be sure to upload them in the same Region in which you intend to create the Client VPN endpoint. The following commands use the AWS CLI to upload the certificates. To upload the certificates using the ACM console instead.

$ cd ~/awsclientvpn/

$ aws acm import-certificate --certificate fileb://server.crt --private-key fileb://server.key --certificate-chain fileb://ca.crt

$ aws acm import-certificate --certificate fileb://client1.domain.tld.crt --private-key fileb://client1.domain.tld.key --certificate-chain fileb://ca.crt
```
## Step 2: Create a Client VPN endpoint.
```
To create a Client VPN endpoint

1. Open the Amazon VPC console.
2. In the navigation pane, choose Client VPN Endpoints and then choose Create Client VPN endpoint.
3. (Optional) Provide a name tag and description for the Client VPN endpoint.
4. For Client IPv4 CIDR, specify an IP address range, in CIDR notation, from which to assign client IP addresses. For example, 20.0.0.0/20.

NOTE : The address range cannot overlap with the target network address range, the VPC address range, or any of the routes that will be associated with the Client VPN endpoint. You cannot change the client address range after you create the Client VPN endpoint.

5. For Server certificate ARN, select the ARN of the server certificate that you generated in Step 1.

NOTE: Make sure the server certificate is provisioned with or imported into AWS Certificate Manager (ACM) in the same AWS Region.

6. Under Authentication options, choose Use mutual authentication, and then for Client certificate ARN, select the ARN of the certificate that we imported in Step 1.

![vpn](https://github.com/AwsOperations/Kubernetes/assets/134834806/bcdfe7d6-59c5-489e-b543-d0e9fccf3717)

7. Enable Split tunnel.

8. You can Choose your custome vpc which you have created.

9. And choose appropriate security group in my case its private.

10. Vpn port is 443
```
## Step 3: Associate a target network.
```
To allow clients to establish a VPN session, we associate a target network with the Client VPN endpoint. A target network is a Public subnet in a VPC. To associate a target network with the Client VPN endpoint follow the following steps

1. Open the Amazon VPC console, In the navigation pane, choose Client VPN Endpoints.

2. Select the Client VPN endpoint that you created in the preceding procedure, and then choose Target network associations, Associate target network.

3. For VPC, choose the VPC in which our subnet is located.

4. For Choose a subnet to associate, choose the subnet to associate with the Client VPN endpoint.

5. Choose Associate target network.
```
## Step 4: Add an authorization rule for the VPC.
```
To add an authorization rule for the VPC follow these steps

1. Open the Amazon VPC console, In the navigation pane, choose Client VPN Endpoints.

2. Select the Client VPN endpoint to which to add the authorization rule. Choose Authorization rules, and then choose Add authorization rule.

3. For Destination network to enable access, enter the CIDR of the network for which you want to allow access. For example, to allow access to the entire VPC, specify the IPv4 CIDR block of the VPC.

https://miro.medium.com/max/875/1*byiii6Ihg-YAT2ThnBVUSQ.png

4. For Grant access to, choose Allow access to all users.

5. (Optional) For Description, enter a brief description of the authorization rule.

6. Choose Add authorization rule.
```
## Step 5: Provide access to the internet
```
To provide access to the internet

1. Open the Amazon VPC console, In the navigation pane, choose Client VPN Endpoints.

2. Select the Client VPN endpoint that you created for this tutorial. Choose Route Table, and then choose Create Route.

3. For Route destination, enter 0.0.0.0/0. For Subnet ID for target network association, specify the ID of the subnet through which to route traffic.

4. Choose Create Route.

5. Choose Authorization rules, and then choose Add authorization rule.

6. For Destination network to enable access, enter 0.0.0.0/0, and choose Allow access to all users.

7. Choose Add authorization rule.
```
## Step 6: Download the Client VPN endpoint configuration file.
```
The next step is to download and prepare the Client VPN endpoint configuration file. We provide this file to the end-users who need to connect to the Client VPN endpoint. To download and prepare the Client VPN endpoint configuration file

1. Open the Amazon VPC console, In the navigation pane, choose Client VPN Endpoints.

2. Select the Client VPN endpoint that you created for this tutorial, and choose Download client configuration.

3. Locate the client certificate and key that were generated in Step 1. The client certificate and key can be found in the following locations in the cloned OpenVPN easy-rsa repo:

* Client certificate — easy-rsa/easyrsa3/pki/issued/client1.domain.tld.crt

* Client key — easy-rsa/easyrsa3/pki/private/client1.domain.tld.key

4. Open the Client VPN endpoint configuration file using your preferred text editor. Add and tags to the file. Place the contents of the client certificate and the contents of the private key between the corresponding tags, as such:

<cert>
Contents of client certificate (.crt) file
</cert>

<key>
Contents of private key (.key) file
</key>

5. Locate the line that specifies the Client VPN endpoint DNS name, and prepend a random string to it so that the format is random_string.displayed_DNS_name. For example:

Original DNS name: cvpn-endpoint-0102bc4c2eEXAMPLE.prod.clientvpn.us-west-2.amazonaws.com

Modified DNS name: asdfa.cvpn-endpoint-0102bc4c2eEXAMPLE.prod.clientvpn.us-west-2.amazonaws.com

6. Save and close the Client VPN endpoint configuration file.

7. Distribute the Client VPN endpoint configuration file to your end-users.
```
## Step 8: Connect to the Client VPN endpoint.
```
Download the OpenVPN client here https://openvpn.net/vpn-client/

Here we used ubuntu and are using the OpenVPN command to connect to VPN

sudo openvpn --config <filename.ovpn>
```
## Step 9: Connect to the Client Vpn endpoint for windows.
```
Download the OpenVPN client here https://openvpn.net/vpn-client/

Open the configuration file in Notepad

After the ca certificate key below paste the below lines and in the middle of the content open your (client1.domain.tld.crt) if you are using linux mission use cat command to view and copy the key paste inside middle of the content and save as .ovpn extension and import the config file via openvpn client.

$ cat client1.domain.tld.crt
$ cat client1.domain.tld.key

<cert>
Contents of client certificate (.crt) file
</cert>

<key>
Contents of private key (.key) file
</key>
```

