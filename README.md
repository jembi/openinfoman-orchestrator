OpenInfoMan Orchestrator
========================

This orchestrator allow polls the OpenInfoMan library using a user defined interval. It also makes a call to merge services once all of the polling requests have been completed.

How to run
----------

To run the application you need to have node.js isntall and you will need the CoffeeScript package to compile the source.

Download and install node [from here](http://nodejs.org/).

Once install use npm to install CoffeeScript

	sudo npm install -g coffee-script

Compile the source file:

	coffee -c server.coffee

Run the produced javascript file with node:

	node server.js

Done!