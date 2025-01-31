# TerraformS3

CREATE YOUR WEBSITE ON AWS  USING TERRAFORM  


STEP 1: Install Terrfaorm from official documentaion
```bash 
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
Install the HashiCorp GPG key.
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
Verify the key's fingerprint.
```bash 
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
The gpg command will report the key fingerprint:
```
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 XXXX-XX-XX [SC]
AAAA AAAA AAAA AAAA
uid           [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 XXXX-XX-XX [E]
```
Add the official HashiCorp repository to your system
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
Download the package information from HashiCorp.
```bash
sudo apt update
sudo apt-get install terraform
```
Verify the terraform installation 
```bash 
terraform -v
```
Step 2: Create ```provider.tf``` file in the working directory

Step 3: Search for ```aws terraform provider``` in the browser (Official documentaion recommended).

	Copy code into the ```provider.tf```
	
	Define Provider ```region = us-east-1```
Step 4: In the terminal Initialize terraform
```bash 
terraform init
```
Step 4: Create ```main.tf``` file

		```Search terraform s3 resource``` in the browser (Official documentaion recommended)
		
		Copy the code for bucket and paste in ```main.tf```
		
	NOTE: The bucket name should be unique globally.
	
Step 5: Create ```variable.tf``` to define the unique bucket names and map it into ```main.tf``` and help create S3 bucket in your aws

		```bash
		bucket = var.bucketname
		```
Step 6:  terraform plan (Terraform will perform the following actions:

  # aws_s3_bucket.myS3Bucket will be created
  + resource "aws_s3_bucket" "myS3Bucket")
```bash 
terraform plan
```

NOTE : - Make sure you have done the ```aws configure``` 

		- Ensure bucket name is all lowercase
		
		- It does not allow any special character other than hypen ( - ).
		
Step 7: terraform apply [To apply the configuration to create the resource)
```bash
terraform apply -auto-approve
```
- Refresh you S3 bucket page on the AWS console . It will have the S3 bucket created through terrfaorm (IaC)

STEP 8: IN ```main.tf``` add the following resource

- To Change the ownership of the bucket (In registry : ```aws_s3_bucket_ownership_controls```)

- Change Bucketname.id (myS3Bucket.id)

- TO MAKE BUCKET PUBLIC ```aws_s3_bucket_public_access_block``` (In registry) Chnage the values to false(In ```main.tf```)

- Change Bucketname.id (myS3Bucket.id)

-To add Access Control List [ACL] ```aws_s3_bucket_acl``` (In registry)

	APPLY ACL (PUBLIC READ)
	
Step 9: terraform apply [To apply the configuration to create the resource)
```bash
terraform apply -auto-approve
```

Step 10 : ```aws_s3_bucket_website_configuration``` This requires ```index.html``` and ```error.html``` so we need to add these objects into the s3 bucket FIRST

	-Create ```index.html``` and ```error.html```  in the working directory
	
	NOTE: Use chatgpt for creation of index.html if u r not familiar with html
	
	- To add Objects in the bucket```aws_s3_object``` Add 3 Objects (index.html , error.html and a image )
	
Step 11: terraform apply [To apply the configuration to create the resource)
```bash
terraform apply -auto-approve
```

STEP 12: To configure the website on terraform  ```aws_s3_bucket_website_configuration```

	- ```bash
terraform apply -auto-approve
```

- This will make the ```static website hosting``` in the properties(in aws console) of the bucket created . static website hosting will be enabled

-Click on the link . HURRAYYYY!!! YOUR WEBSITE IS HOSTED

Step 13: Create ```outputs.tf``` to get the endpoint of the website

- ```bash
terraform apply -auto-approve
```

