terraform {
  backend "http" {
    address        = "https://ffddorf-terraform-backend.fly.dev/state/supernodes-v2/dev"
    lock_address   = "https://ffddorf-terraform-backend.fly.dev/state/supernodes-v2/dev"
    unlock_address = "https://ffddorf-terraform-backend.fly.dev/state/supernodes-v2/dev"
    username       = "github_pat"
  }
}
