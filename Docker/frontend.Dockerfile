FROM nginx:1.27-alpine
# Copy static UI
COPY dist/ /usr/share/nginx/html/
# Use our proxy config
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
