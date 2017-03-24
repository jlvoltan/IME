#!/bin/bash

echo "5 curriculos base para schema"
xmllint --noout --schema Parte_2/schema.xsd Parte_2/5_validados/*

echo ""

echo "20 curriculos ajustados pelo XQuery"
xmllint --noout --schema Parte_2/schema.xsd Parte_3/Novos_20_curriculos/*