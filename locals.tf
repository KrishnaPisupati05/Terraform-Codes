locals {
  resource_location = "East Asia"

  virtual_network= {
  name  = "app-net"
  address_prefixes = ["10.0.0.0/16"]
  }
























  # virtual_network={
  #   name="app-network"
  #   address_prefixes=["10.0.0.0/16"]
  # }
}
#   subnets=[
#     {
#         name="websubnet01"
#         address_prefixes=["10.0.0.0/24"]
#     },
#     {
#         name="appsubnet01"
#         address_prefixes=["10.0.1.0/24"]
#     }
#   ]
