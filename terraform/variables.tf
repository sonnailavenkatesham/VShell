variable "instance_names" {
  type    = list(any)
  default = ["mongodb", "catalogue", "user", "cart", "redis", "web"]
}