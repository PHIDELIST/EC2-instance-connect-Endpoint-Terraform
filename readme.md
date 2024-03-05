## Connecting to the EC2 in private subnet
Use ssh and the open-tunnel AWS CLI command as follows. The -o proxy command encloses the open-tunnel command that creates the private tunnel to the instance.

```
ssh -i my-key-pair.pem ec2-user@i-0123456789example \
    -o ProxyCommand='aws ec2-instance-connect open-tunnel --instance-id i-0123456789example'
```
For:

-i – Specify the key pair that was used to launch the instance.

ec2-user@i-0123456789example – Specify the username of the AMI that was used to launch the instance, and the instance ID.

--instance-id – Specify the ID of the instance to connect to. Alternatively, specify %h, which extracts the instance ID from the user.

