terraform {
  backend "http" {
    # see https://tfstate.dev/ for instructions
    address        = "https://api.tfstate.dev/github/v1"
    lock_address   = "https://api.tfstate.dev/github/v1/lock"
    unlock_address = "https://api.tfstate.dev/github/v1/lock"
    lock_method    = "PUT"
    unlock_method  = "DELETE"
    username       = "ffddorf/supernodes-v2@dev"
  }
}
