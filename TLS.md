---
marp: true
---
# Practical TLS

---
# Quick terminology

- TLS most often used to protect HTTP traffic, forming the HTTPS protocol
- Many other protocols can be wrapped in TLS
- Several standard versions, you may have seen:
  - SSL v3, TLS 1.0, TLS 1.1, TLS 1.2, TLS 1.3
  - You need to be TLS 1.2 or 1.3 at this point

---
# Quick terminology

- A cipher suite will be composed of four parts
  - Example configurations
    - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
    - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
  - Connection authentication - ECDSA/RSA
  - Key exchange - ECDHE
  - Bulk cipher - AES_128_GCM
  - Hashing - SHA256

---
# Certificate Authorities

- TLS requires a certificate to operate, which is a signature on your public key
- Signatures can be done by yourself, by an in-house authority, or by a well-known public authority
- TLS clients have a built-in list of public authorities they trust
  - How much these businesses should be trusted is another presentation, but the Internet is frequently built on fragile assumptions
- Many charge for the "privilege" of asserting your "authenticity", but Let's Encrypt has disrupted a lot of that
- Some servers can now complete an automatic validation against Let's Encrypt and request their own certificates

---
# Certificate Authorities

- The "root" certificate that forms the basis of their trust is frequently generated with a 20-30yr lifespan, and then locked in a vault, offline
- The vault is occasionally opened to sign an "intermediate" certificate, valid for 5-10yr
- This strategy limits the fallout from a compromised certificate, as the intermediate could be revoked and reissued, without having to update client trust lists
- Servers present their certificate, as well as any intermediate certificates leading back to the root when a client connects

---
# Fun with TLS

- Scan a server with <https://www.ssllabs.com>
- Examine a server with `openssl s_client -connect host:port`
  - Add `-showcerts` for intermediate information
  - Add `-status` to see if the server can get an updated validity check (OCSP)
- Examine a certificate by piping it to `openssl x509 -text`
- Combine the two for extra info about the server's cert
- Scan several servers with `nmap -sV --script ssl-enum-ciphers -p 443 <host>`
