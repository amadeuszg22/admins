upstream lb-viatolldev {
      ip_hash;
      server 192.168.10.12:80;
}
upstream lb-viatolldev-phpmyadmin {
      ip_hash;
      server 192.168.10.30:80;
}

 
server {
      listen 80;
 
      server_name viatoll3.pl www.viatoll3.pl; 
      access_log  /var/log/nginx/nginx.access.subprint.log;
      error_log  /var/log/nginx/nginx_error.subprint.log debug;
 
      location / {
        proxy_pass http://lb-viatolldev; # Load balance the URL location "/" to the upstream lb-subprint
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

      location /phpmyadmin {
        proxy_pass http://lb-viatolldev-phpmyadmin/phpmyadmin; # Load balance the URL location "/" to the upstream lb-subprint
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
      }


      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
            root   /var/www/nginx-default;
  
 proxy_redirect     off;    
 }
}
