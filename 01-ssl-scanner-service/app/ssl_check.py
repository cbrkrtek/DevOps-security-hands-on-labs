import ssl
import socket
import os
import logging
import redis
from datetime import datetime
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)
REDIS_HOST = os.getenv("REDIS_HOST", "database")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))
def get_ssl_expiry(hostname):
    context = ssl.create_default_context()
    try:
        with socket.create_connection((hostname, 443), timeout=5) as sock:
            with context.wrap_socket(sock, server_hostname=hostname) as ssock:
                cert = ssock.getpeercert()
                expire_date = cert['notAfter']                
                return datetime.strptime(expire_date, '%b %d %H:%M:%S %Y %Z')
    except Exception as e:
        logger.error(f"Failed to check {hostname}: {e}")
        return None
def main():
    try:
        r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)
        r.ping()
    except Exception as e:
        logger.error(f"Could not connect to Redis: {e}")
        return
    domains_env = os.getenv("DOMAINS") or "google.com,github.com"
    target_domains = domains_env.split(",")
    logger.info("Starting SSL Expiration Check...")
    for domain in target_domains:
        domain = domain.strip()
        expiry = get_ssl_expiry(domain)
        if expiry:
            days_left = (expiry - datetime.now()).days
            #save to Redis
            key = f"ssl_check:{domain}"
            r.set(key, days_left)
            r.expire(key, 86400)
            if days_left < 14:
                logger.warning(f"CRITICAL: {domain} expires in {days_left} days!")
            else:
                logger.info(f"OK: {domain} has {days_left} days remaining. Saved to Redis.")
if __name__ == "__main__":
    main()
