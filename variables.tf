variable "DO_TOKEN" {
  description = "The DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "SSH_PUBLIC_KEY" {
  description = "The DigitalOcean Public Key"
  type        = string
  sensitive   = true
}