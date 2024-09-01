terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

resource "digitalocean_droplet" "personal_web_server" {
  image  = "ubuntu-22-04-x64"
  name   = "js-ubuntu-personal-resume-website"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    var.SSH_PUBLIC_KEY
  ]
}

resource "digitalocean_floating_ip" "web_server_static_ip" {
  region = "nyc1"
}

resource "digitalocean_floating_ip_assignment" "web_server_static_ip_assignment" {
  ip_address = digitalocean_floating_ip.web_server_static_ip.ip_address
  droplet_id = digitalocean_droplet.personal_web_server.id
}

resource "digitalocean_record" "dns_resource" {
  domain = "jstafford.xyz"
  name   = "@"
  type   = "A"
  value  = digitalocean_floating_ip.web_server_static_ip.ip_address
  ttl    = 3600
}

output "droplet_ip" {
  value = digitalocean_floating_ip.web_server_static_ip.ip_address
}

output "droplet_status" {
  value = digitalocean_droplet.personal_web_server.status
}

output "floating_ip_address" {
  value = digitalocean_floating_ip.web_server_static_ip.ip_address
}