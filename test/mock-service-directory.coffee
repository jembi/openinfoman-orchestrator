http = require 'http'
fs = require 'fs'

file = process.argv[2]
port = process.argv[3]

CSD = String fs.readFileSync file
CSD = CSD.replace '<?xml version="1.0" encoding="UTF-8"?>', ''

http.createServer (req, res) ->
	console.log 'Recieved a request! Responding...'
	res.writeHead 200, 'Content-Type': 'text/xml'
	res.write """
    				  <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:wsa="http://www.w3.org/2005/08/addressing" xmlns:csd="urn:ihe:iti:csd:2013">
                <soap:Header>
                  <wsa:Action soap:mustUnderstand="1">urn:ihe:iti:csd:2013:GetDirectoryModificationsResponse</wsa:Action>
                  <wsa:MessageID>urn:uuid:060bf1f5-a5d8-4741-86c6-cb240f887e5b</wsa:MessageID>
                  <wsa:To soap:mustUnderstand="1"> http://www.w3.org/2005/08/addressing/anonymous</wsa:To>
                  <wsa:RelatesTo>urn:uuid:def119ad-dc13-49c1-a3c7-e3742531f9b3</wsa:RelatesTo>
                </soap:Header>
                <soap:Body>
                  <csd:getModificationsResponse>
            """ + CSD + """
                  </csd:getModificationsResponse>
                </soap:Body>
              </soap:Envelope>
    			  """
	res.end()
.listen port

console.log 'Mock target listening on ' + port + ' and return file: ' + file