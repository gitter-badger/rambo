rm -rf /var/tmp/rambo-local-run
mkdir -p /var/tmp/rambo-local-run

cat > /var/tmp/rambo-local-run/python-payload.b64 <<'PYTHONBASE64DATA'
{{ foo }}
PYTHONBASE64DATA

base64 --decode /var/tmp/rambo-local-run/python-payload.b64 > /var/tmp/rambo-local-run/python-payload.tar.gz
mkdir -p /var/tmp/rambo-local-run/venv
tar -xvzf /var/tmp/rambo-local-run/python-payload.tar.gz -C /var/tmp/rambo-local-run/venv
cd /
#chmod +x /var/tmp/rambo-local-run/venv/.tmp/build/bash/venv/bin/python
./var/tmp/rambo-local-run/venv/.tmp/build/bash/venv/bin/python2 /var/tmp/rambo-local-run/venv/.tmp/build/bash/venv/bin/salt-call --local test.ping
cd -

rm -rf /var/tmp/rambo-local-run
