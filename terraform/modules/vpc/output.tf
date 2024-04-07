output "project_name" {
value = var.project_name  
}
output "region"{
value = var.region
} 
output "vpc_id"{
value = aws_vpc.vpc.id    
}
output "vpc_cidr" {
 value = var.vpc_cidr     
}
output "pub_sub_1a_id" {
value = aws_subnet.pub_sub_1a.id
}
output "pub_sub_2b_id" {
value = aws_subnet.pub_sub_2b.id
}

output "igw_id" {
    value = aws_internet_gateway.igw
}