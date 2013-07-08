NODE_BIN := './node_modules/.bin/'

all: deps
	
require-npm:
	@test `which npm` || echo 'Node.js required: http://nodejs.org/'

deps: require-npm
	npm install

start:
	$(NODE_BIN)brunch watch --server

.PHONY: all require-npm deps watch
