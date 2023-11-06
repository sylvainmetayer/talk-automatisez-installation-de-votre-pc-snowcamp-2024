#!/usr/bin/env bash

echo "- Mode Ne Pas Deranger actif ?"
echo "- Les slides sont disponible en local au cas ou ?"

echo "Battery saver"
sudo systemctl stop docker.service
sudo systemctl stop cbagentd.service
sudo systemctl stop forticlient.service

qrencode https://openfeedback.io/bdxio2023/2023-11-10/622 -o slides/assets/img/openfeedback.svg -t SVG -l H -m 2
qrencode https://r.sylvain.dev/bdxio-2023 -o slides/assets/img/slides_link.svg -t SVG -l H -m 2
