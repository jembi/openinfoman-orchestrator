ServiceDirectory Mock Service
=============================

Provides a mock serrvice for the CSD ServiceDirectory get updated services transaction

How to run
----------

Compile with CoffeeScript and run the server and pass it a CSD xml file to return statically and a port to run on.

	node mock-service-directory.js CSD-Services-Connectathon-20131227.xml 8080

You may fire up multiple off these on different port each serving differnt files.