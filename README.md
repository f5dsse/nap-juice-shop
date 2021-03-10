# NGINX App Protect demo with OWASP Juice Shop


## Requirements: 
* git
* docker
* docker-compose

## Instructions: 

1. Sign up for an NGINX+/NGINX App Protect trial at [https://www.nginx.com/free-trial-request](https://www.nginx.com/free-trial-request/)
2. Clone this repository:

        git clone https://github.com/f5dsse/nap-juice-shop.git

3. Copy the nginx-repo.crt and nginx-repo.key files you got from the trial downloads into the nginx_app_protect/ folder.
4. Run docker-compose to build NAP image and bring up services:

        docker-compose up -d

5. Modify the custom_policy.json following the configuration guide here: [https://docs.nginx.com/nginx-app-protect/configuration/#](https://docs.nginx.com/nginx-app-protect/configuration/#)
6. Try some attacks against the application at http://localhost:80 (if port 80 is already in use just modify docker-compose.yml to expose a different port, i.e.: 

        nginx_app_protect:
          build: nginx_app_protect
          ports:
            - "8081:80"
