generate_pm2_file() {
  TLS=${NEZHA_TLS:+'--tls'}
  cat > /tmp/ecosystem.config.js << EOF
module.exports = {
  "apps":[
      {
EOF

  [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_PORT}" && -n "${NEZHA_KEY}" ]] && cat >> /tmp/ecosystem.config.js << EOF
      },
      {
          "name":"nezha",
          "script":"/home/yeleeuser/nezha-agent",
          "args":"-s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS}"
EOF

  cat >> /tmp/ecosystem.config.js << EOF
      }
  ]
}
EOF
}

generate_pm2_file
[ -e /tmp/ecosystem.config.js ] && pm2 start /tmp/ecosystem.config.js
wait
