#!/usr/bin/env bash

echo "- Mode Ne Pas Deranger actif ?"
echo "- Les slides sont disponible en local au cas ou ?"

echo "Battery saver"
sudo systemctl stop docker.service
sudo systemctl stop cbagentd.service
sudo systemctl stop forticlient.service

echo "TODO Generate QR Code"
