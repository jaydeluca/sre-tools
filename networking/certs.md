# OpenSSL

Cert info
`echo | openssl s_client -showcerts -servername google.com -connect google.com:443 2>/dev/null | openssl x509 -inform pem -noout -text`

Full chain info
`openssl s_client -connect google.com:443 -showcerts -CAfile /etc/ssl/certs/ca-certificates.crt
`

### TLS Version Validation

If cert chain and handshake returned, version is supported.  
If no cert chain returned or "handshake error", not supported.
```bash
openssl s_client -connect www.google.com:443 -tls1_2
openssl s_client -connect www.google.com:443 -tls1_1
openssl s_client -connect www.google.com:443 -tls1
```
