## Avoiding the use of basiton Host to connect to ec2 in private subnet
AWS EC2 instance connect endpoint service was introduced by AWS to remove the headache of provisioning and configuring a basiton host just to connect to instances on private subnet.
This project is a simple terraform code that will provision an EC2 instance in a private subnet with instance connect endpoint already configure allowing you to easily connect to the EC2 instance from the internet.
#### Architecture
![Blank diagram (2)](https://github.com/PHIDELIST/EC2-instance-connect-Terraform/assets/64526896/134051c6-30fc-4fde-8659-830b289052a4)

### Deployment
- Login into AWS console then navigate to AWS EC2 dashboard.
  ![Screenshot 2024-03-09 090247](https://github.com/PHIDELIST/EC2-instance-connect-Terraform/assets/64526896/cac4be33-f71c-4d55-8dd3-3f0a47c429ed)
  ![Screenshot 2024-03-09 090601](https://github.com/PHIDELIST/EC2-instance-connect-Terraform/assets/64526896/ba82f128-4aa0-4095-a346-51e0bb364dc4)
  ![Screenshot 2024-03-09 090725](https://github.com/PHIDELIST/EC2-instance-connect-Terraform/assets/64526896/43217977-2df5-470e-b3b0-e10189f51868)
- This will create and automatically download the key pair that you will use to connect to the ec2
- In the main.tf update the key_name with the key pair name you created ```  key_name = "<key_pair_name>" # Replace <key_pair_name> with the key pair name you created```
  
###### Run the following commands to deploy the resources
+ terraform init
+ terraform apply
  
### Connecting to the EC2 in private subnet Using ssh and the open-tunnel AWS CLI command
+ The -o proxy command encloses the open-tunnel command that creates the private tunnel to the instance.

```
ssh -i my-key-pair.pem ec2-user@i-0123456789example \
    -o ProxyCommand='aws ec2-instance-connect open-tunnel --instance-id i-0123456789example'
```
For:
-i – Specify the key pair that was used to launch the instance.

ec2-user@i-0123456789example – Specify the username of the AMI that was used to launch the instance, and the instance ID.

--instance-id – Specify the ID of the instance to connect to. Alternatively, specify %h, which extracts the instance ID from the user.

## Clean UP
run ```terraform destroy```

