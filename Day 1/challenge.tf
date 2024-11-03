#CHALLENGE : Create a file in your local machine using terraform

resource "null_resource" "file" {
    provisioner "local-exec" {
        command = "echo 'Mesage: ${upper("Hello world!")}' > challenge.txt"
      
    }
  
}