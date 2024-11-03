#Learning Terraform and Hashicorp Configuration Language

#Documentation ------ https://developer.hashicorp.com/terraform/language

#Comments
#This is a single line comment
/*
This is
a multi line
comment */

#Block
#A block is a container for other content. Blocks are defined by their types and enclosed in curly braces

block_type "optional parameter" {
    attribute1 = value1
    attribute2 = value2
}

resource "aws_instance" "example" {
    ami = "ami-value"
    instance_type = "t2.micro"
    count = 3 
}

#Attributes
#Attributes are key value pairs
#key = value1


#Data types
# string - a string of characters enclosed in quotes
#"variable", "items", "instance"

# number - a numerical value
#1, 2, 3, 4, 5, 6, 7

# boolean - used to evaluate true or false statements
#true false

# list - are enclosed in square brackets
/*
myList = ["item1", "item2", "item3"]
security_groups = ["sg-2143", "sg.32415"]
subnets = ["private_subnet", "public_subnet"]
*/

# maps are defined using curly braces and they follow the key value pair syntax similar to dictionary in Python and other programming languages.

variable "example_map"{
    type = map
    default = {
        key1 = "value1",
        key2 = "value2",
        key3 = "value3"
    }
}

locals {
    my_map = {
        "name" = "John Doe",
        "age" = 30,
        "is_admin" = true
    }
}
 
 #to get the age of John Doe, we have
 #locals.my_map["age"]

#Conditions
/*conditions are used for making decisions and executing certain blocks of code 
for instance when deploying instances or other compute resources to different environments such as development, staging, testing or production environments
conditions can also be used for evaluating certain criteria or features on resources
for example, if the instance "Webserver" is running, then stop it,
if the instance is in production, then attach a database else not
if an instance is termianted, then create another one using the launch template
if database is in public subnet, don't connect to ec2 instance, else connect, etc
if cpu capacity is more than 60%, then launch another instance
The tenary operator is used to create conditions
*/
resource "aws_instance" "server" {
    instance_type = var.environment == "development" ? "t2.micro" : "t2.small"
}


#Functions
/*Functions in HCL are simalar to functions in other programming languages
There are string functions, numeric functions, date and time functions, etc
*/

locals {
    name = "John Cena"
    fruits = ["apples", "banana", "mango"]
    message = "Hello ${upper(locals.name)}! I know you like ${join(",", locals.fruits)}"
}


#Resource dependencies
#Resource dependencies are used to show that a certain resource dedends on another or is attached to another. for instance, an instance can be attached to a security group or vpc

resource "aws_instance" "server" {
    vpc_security_group_ids =  aws_security_group.mysg.id
  
}

resource "aws_security_group" "mysg" {
    #inbound rules
  
}

#### another example used to create a subnet in a vpc
resource "aws_vpc" "mynewvpc" {
    cidr_block = var.cidr_block
    tags = {
        name = var.vpcname
    }
  
}

resource "aws_subnet" "mysubnet1" {
    vpc_id = aws.vpc.mynewvpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      name = "Subnet1"
    }
}

resource "aws_subnet" "mysubnet2" {
    vpc_id = aws.vpc.mynewvpc.id
    cidr_block = "10.0.2.0/24"

    tags = {
      name = "Subnet2"
    }
}