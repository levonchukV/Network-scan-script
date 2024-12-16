#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Error! Try sudo"
  exit 1
fi

OUTPUT_FILE="Output.log"

> "$OUTPUT_FILE"

run_nmap() {
  echo "--- Nmap Scan ---" >> "$OUTPUT_FILE"
  nmap -sV -T4 -F 127.0.0.1 >> "$OUTPUT_FILE" 2>&1
}

run_tcpdump() {
  echo "--- Tcpdump Capture ---" >> "$OUTPUT_FILE"
  timeout 10 tcpdump -i eth0 -c 50 -nn >> "$OUTPUT_FILE" 2>&1
}

run_nmap
run_tcpdump

echo "Log saved! $OUTPUT_FILE"