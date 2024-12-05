```Bash
apt get libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev libgd-dev libgeoip-dev libperl-dev

wget https://openresty.org/download/openresty-1.25.3.1.tar.gz

./configure --prefix=/opt/woody/openresty \
            --with-pcre-jit \
            --with-ipv6 \
            --with-http_ssl_module \
            --with-http_v2_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_xslt_module \
            --with-http_image_filter_module \
            --with-http_geoip_module \
            --with-http_sub_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_degradation_module \
            --with-http_stub_status_module \
            --with-http_auth_request_module \
            --with-threads \
            --with-stream \
            --with-stream_ssl_module \
            --with-stream_geoip_module \
            --with-stream_ssl_preread_module \
            --with-stream_realip_module \
            --with-mail \
            --with-mail_ssl_module
            
make && make install

/opt/openresty/bin/opm  get ledgetech/lua-resty-http
```