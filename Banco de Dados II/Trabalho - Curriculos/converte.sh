#!/bin/bash
npm install
for file in $( ls ./Parte_3/Novos_20_curriculos | sed "s/\\..*//g"); do
node <<EOF
var fs = require("fs");
var util = require("util");
var parser = require("xml2json")
fs.readFile("./Parte_3/Novos_20_curriculos/$file.xml","utf-8",function(err,data){
	if(err){
		console.log("erro ao converter $file");
		console.log(err);
	}else{
		fs.writeFile("./Parte_4/JSON/$file.json",parser.toJson(data),function(){
			console.log("arquivo $file convertido com sucesso!");
		})
	}
});
EOF
done

for file in $( ls ./Parte_2/5_validados | sed "s/\\..*//g"); do
node <<EOF
var fs = require("fs");
var util = require("util");
var parser = require("xml2json")
fs.readFile("./Parte_2/5_validados/$file.xml","utf-8",function(err,data){
	if(err){
		console.log("erro ao converter $file");
		console.log(err);
	}else{
		fs.writeFile("./Parte_4/JSON/$file.json",parser.toJson(data),function(){
			console.log("arquivo $file convertido com sucesso!");
		})
	}
});
EOF
done