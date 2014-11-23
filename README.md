## ebs_backups cookbook
This cookbook installs the AWSCLI as well as a backup script taken from [aws-missing-tools](https://github.com/colinbjohnson/aws-missing-tools/tree/master/ec2-automate-backup), and allows you to easily setup automated backups of EBS volumes across your entire AWS account.

## Requirements
It really only depends on the [Opscode Python Cookbook](https://github.com/poise/python) which is needed to install the AWSCLI. You must add all required attributes as described below.

## Attributes
All attributes are namespaced under the `:ebs_backups` tag.
#####[:user]
`node[:ebs_backups][:user]` defines user which runs the backup scripts *(defaults to 'deploy')*

`node[:ebs_backups][:group]` defines group that the above user belongs to *(defaults to 'deploy')*

#####[:aws][:profiles]
Defines neccessary configs to run the AWSCLIas outlined [here](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

#####[:crons]
Defines crons

## Recipes
#####ebs_backups::default 
Includes all of the following recipes
#####ebs_backups::aws_backup
Copies over the automated backup script and creates all crons outlined in attributes
#####ebs_backups::aws_cli
Installs the AWSCLI as well as python
#####ebs_backups::user
Creates a user

## Author

[Sport Ngin](www.github.com/sportngin)
