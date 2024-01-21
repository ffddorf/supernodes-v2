data "http" "github_keys" {
  for_each = toset(var.ssh_github_users)
  url      = "https://github.com/${each.key}.keys"
}

locals {
  ssh_keys = flatten([for name, resp in data.http.github_keys : split("\n", chomp(resp.response_body))])
}
