output "ipaddress" {
    value = "${aws_instance.server.public_ip}"
    description = "Public IP of docker server"
}