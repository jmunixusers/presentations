---
marp: true

---
# Networking Overview

---
# A few very broad topics to mention

- Networking layers
- Numbering & subnets
- Protocols we’re using today
  - DHCP
  - ICMP
  - OSPF

---
# Networking Layers

The OSI networking model defines seven layers and has been described as the most beautiful model that’s never been implemented.

- Application
- Presentation
- Session
- Transport
- Network
- Data-link
- Physical

---
# Networking layers

- Application - how messages are formed. HTTP, SMTP, etc live here.
- ~~Presentation~~
- IT majors only below this point
- ~~Session~~
- Transport - how data flows between nodes. TCP and UDP live here.
- Network - how nodes are identified. IP addresses live here.
- Data-link - how multiple speakers coordinate transmitting (CSMA/CD). MAC
addresses live here.
- Physical - the media to connect nodes: copper, fiber, radio

---
# Numbering - MAC addresses

- 48 bits represented as pairs of hex digits - 78:2b:cb:9d:ed:1f
- 24 bits for vendor, 24 bits for device
- Factory programmed, but usually reconfigurable
- Designed to be globally unique, but accidents happen

---
# Numbering - IPv4 (or just “IP”) addresses

- 32 bits represented as dotted-decimal - 134.126.126.99
- Maximum range from 0.0.0.0 - 255.255.255.255 with a lot of exceptions
- Some portion on the left represents the subnet. The remainder on the right
represents the host. Subnet mask determines the split.

---
# Numbering - IPv6 addresses

- Next-generation Internet uses IPv6 protocol
- Not going there tonight
- But in case you see one in the wild...
- 128 bits in groups of four hex digits
- 2607:f8b0:4004:810::2004
- One group of contiguous zeroes can be abbreviated with "::"

---
# Numbering - subnets

- All networks must have a subnet defined - the number of bits used to
determine if another computer is local or must be routed via a gateway
- Can be represented with long or short form
  - 255.255.255.0 or /24 - 256 addresses
  - 255.255.0.0 or /16 - 65,536 addresses
  - 255.0.0.0 or /8 - 16,777,216 addresses
  - Or anything in between

---
# Numbering - private subnets

- Three address ranges defined by RFC 1918 for internal/private usage
  - 10.0.0.0/8 (255.0.0.0)
  - 172.16.0.0/12 (255.240.0.0)
  - 192.168.0.0/16 (255.255.0.0)

---
# Numbering - putting it all together

- How many of you have configured a home network?
- Was your IP address something like 192.168.1.100?
- Was your subnet mask something like 255.255.255.0?
- Was your default gateway 192.168.1.1?
- Any of this starting to look familiar? :)

---
# Protocols - Dynamic Host Configuration Protocol (DHCP)

- Many networks allow users to connect with no manual configuration of an IP address
- DHCP allows a client to broadcast a request for more information about a network
- A DHCP server or router will respond with information about IP address,subnet mask, gateway, and DNS servers
- We’re using this to accelerate building our network
  - Port 1 and 2 are DHCP servers
  - Port 3 and 4 are DHCP clients

---
# Protocols - Internet Control Message Protocol (ICMP)

- Allows systems to exchange “control” messages about their status
- Common uses are `ping` and `traceroute` utilities
- Ping sends an “echo request” and if successfully received, an “echo reply” will be sent
- Traceroute sends a series of requests toward a destination and attempts to
discover routers along the way
- Don’t trust everything they tell you, but they should work well enough for our lab

---
# Protocols - Open Shortest Path First (OSPF)

- By default, devices only know how to send packets within their subnet
- OSPF enabled routers broadcast information about all their subnets
- They also receive these broadcasts and build a map of their surroundings
- Every link has a cost, and a Dijkstra-ish algorithm tries to find the cheapest path from end-to-end
- Multiple paths of varying costs may be found
  - Pay attention to how ties are broken
- When “link-state” changes, like cables being (un)plugged, new routes are
chosen

---
# Protocols - Routing in general

- OSPF is considered an "interior" routing protocol, used inside an organization
- Other interior protocols include RIP and IS-IS
- Outside an organization, Border Gateway Protocol (BGP) reigns
- BGP thinks bigger picture and finds a path across organizations, leaving the individual interior links to OSPF
