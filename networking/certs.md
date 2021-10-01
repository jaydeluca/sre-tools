# OpenSSL

```bash
# cert info
echo | openssl s_client -showcerts -servername google.com -connect google.com:443 2>/dev/null | openssl x509 -inform pem -noout -text

# full chain info
openssl s_client -connect google.com:443 -showcerts -CAfile /etc/ssl/certs/ca-certificates.crt
```