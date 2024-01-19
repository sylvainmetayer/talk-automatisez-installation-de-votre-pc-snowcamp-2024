#!/usr/bin/env bash

echo "- Mode Ne Pas Deranger actif ?"
echo "- Les slides sont disponible en local au cas ou ?"

echo "Battery saver"
sudo systemctl stop docker.service
sudo systemctl stop cbagentd.service
sudo systemctl stop forticlient.service

#qrencode https://openfeedback.io/o7zyKdkdRulRnrtU3DZo/2024-02-02/6b97ee2f37ba238fa00f0ff7a02b6049 -o slides/assets/img/openfeedback.svg -t SVG -l H -m 2
#qrencode https://r.sylvain.dev/snowcamp-2024 -o slides/assets/img/slides_link.svg -t SVG -l H -m 2
