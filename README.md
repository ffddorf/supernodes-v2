# Supernodes

## IP Addressing

- Assign a single IPv4 address per supernode
  - management IP to reach the machine
  - NAT IP to route client traffic
  - assigned from our `/24` aggregate
- Assign a `/64` loopback prefix for all supernodes in a domain
  - each supernode gets one IP from this prefix
