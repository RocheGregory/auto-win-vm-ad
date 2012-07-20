echo these are commands to be run upon third login post installation
echo create cert request for AD, sign it, and install it
certreq -v -q -new a:\adcertreq.inf c:\adcertreq.req
certreq -v -q -submit -attrib "CertificateTemplate:DomainController" c:\adcertreq.req
echo this assumes the request ID is 2 -  request 1 was the creation of the CA cert itself
echo not sure how it is possible to capture the request ID from the certreq -submit output
set requestid=2
certutil -resubmit %requestid%
certreq -v -q -retrieve %requestid% c:\ad.cer c:\ad.p7b
certreq -v -q -accept c:\ad.p7b
certutil -store my
echo you should now be able to access AD via TLS/SSL
