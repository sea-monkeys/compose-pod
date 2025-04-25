
# ------------------------------------
# Install Python
# ------------------------------------
RUN <<EOF
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:deadsnakes/ppa
apt-get update
apt-get install -y python3.9 python3.9-distutils python3.9-dev python3.9-venv
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9
# Create symlinks
ln -sf /usr/bin/python3.9 /usr/bin/python3
ln -sf /usr/bin/python3.9 /usr/bin/python
ln -sf /usr/local/bin/pip3.9 /usr/local/bin/pip3
ln -sf /usr/local/bin/pip3.9 /usr/local/bin/pip
EOF
