add_proxy() {
  # -- update git
  git config --system http.proxy $HTTP_PROXY
  git config --system https.proxy $HTTPS_PROXY
  git config --list

  # -- update npm
  # echo "registry=http://registry.npmjs.org/" >> ~/.npmrc
  # echo "strict-ssl=false" >> ~/.npmrc
  npm config set proxy $HTTP_PROXY
  npm config set http_proxy $HTTP_PROXY
  npm config set https-proxy $HTTP_PROXY
  # npm config list
  # -- update .ssh/config, commenting out all ProxyCommand directives
  sed -i .bak '/^[#][ ]*ProxyCommand nc.*$/ s/^#\(.*ProxyCommand nc.*$\)/\1/' ~/.ssh/config
}

remove_proxy() {
  git config --system --unset http.proxy
  git config --system --unset https.proxy
  npm config rm proxy
  npm config rm http_proxy
  npm config rm https-proxy
  sed -i .bak '/^[^#][ ]*ProxyCommand nc.*$/ s/\(^.*ProxyCommand nc.*$\)/#\1/' ~/.ssh/config
}
