# UUG Information Security (Cryptography) Presentation

Since this presentation is not directly connected to Unix/Linux, I wanted to provide some context if a non-security focused student wants to jump in and try to give this presentation.

| Presented by   | Date       |
| -------------- | ---------- |
| Nick VanFossen | 04/12/2023 |

---

## The general topics I wanted to cover

- The CIA Triad

- Basic cryptography terminology/concepts

- Kerckhoffs's principle

- Types of Ciphers

  - ECB, CBC, OFB

- Types of Encryption

  - Symmetric encryption

    - One-Time Pad (OTP)

    - Feistel Cipher

    - Data Encryption Standard (DES)

    - Triple DES (3DES)

    - Advanced Encryption Standard

  - Asymmetric encryption

    - Diffie Hellman Key Exchange (DH)

    - Rivest-Shamir-Adleman (RSA)

    - Elliptic-Curve Cryptography (ECC)

- Comparison of Symmetric and Asymmetric Algorithms

- Quantum Threats to Cryptography

---

## Breakdown of the topics

Below is each topic I discussed and what I wanted to achieve with that topic

### The CIA Triad

- Covers the general topics of Confidentiality, Integrity, and Availability. Discussed how the topics work in a way where its mostly pick two, but you cannot choose all three (typically).

### Basic cryptography terminology/concepts

- Explained the basics around `plaintext`, `keys`, `ciphertext`, and `cleartext`.

### Kerckhoffs's principle

- Explained how modern cryptographic algorithms focus on the security of the key. Most of the time, all other aspects of the algorithm are publicly available and open-source.

### Types of Ciphers

- Explained the general difference between a block and stream cipher.

#### Block cipher mode of operations (ECB, CBC, OFB)

- Looked at the different modes and their pros and cons (duplicate ciphertext with same plaintext block, parallelization, if data is lost can you still encrypt/decrypt properly?)

### Types of Encryption

- Looked at the general difference between symmetric and asymmetric encryption.

#### Symmetric encryption

- Graphic of symmetric encryption

##### One-Time Pad (OTP)

- Looked at how OTP is theoretically a perfect secure model for encryption but is not practical to implement.

##### Feistel Cipher

- Looked at how the Feistel Cipher works in general. Explained how most modern ciphers use this model, or a similar "round based" model.

##### Data Encryption Standard (DES)

- Looked at how DES was one of the first US government encryption standards and how DES uses the Feistel Cipher for it's base functionality.

##### Triple DES (3DES)

- Looked at how 3DES is just DES chained three times to add more longevity to the aging standard.

##### Advanced Encryption Standard

- Looked at how AES is the modern symmetric standard that is used in most applications. This section could use more detail on the different functions that occur each round.

#### Asymmetric encryption

- Graphic of asymmetric encryption

##### Diffie Hellman Key Exchange (DH)

- Looked at how DH is the first instance of asymmetric (public keys) and has spawned nearly all other asymmetric algorithms.

- Went over a small example of how the process works. If I was more math inclined, this could be expanded more.

##### Rivest-Shamir-Adleman (RSA)

- Looked at how RSA takes the DH model and relies on the product of two large prime numbers to make cracking computationally difficult.

- Went over a small example of how the process works. If I was more math inclined, this could be expanded more.

##### Elliptic-Curve Cryptography (ECC)

- Looked at how ECC takes the DH model and relies on discrete logarithms to make cracking computationally difficult.

- Went over a small example of how the process works. If I was more math inclined, this could be expanded more.

### Comparison of Symmetric and Asymmetric Algorithms

- Looked at the difference in key size for equivalent security between AES, RSA, and ECC.

### Quantum Threats to Cryptography

- Looked at Grover's and Shor's algorithm and how they affect modern symmetric and asymmetric algorithms.

### (Extra) Cryptographic Hashing

- This topic was an extension of a lightning talk I gave. This could be realistically expanded into its own presentation.

---

## Possible topics that could be added

- Digital signatures

- Digital certificates

- Onion Routing (ToR)

- Passkeys (Passwordless logins)

<!-- https://en.wikipedia.org/wiki/Attack_model -->

- Cryptographic attack models
  - Ciphertext-only attack
  - Known-plaintext attack
  - Chosen-plaintext attack
  - etc.
