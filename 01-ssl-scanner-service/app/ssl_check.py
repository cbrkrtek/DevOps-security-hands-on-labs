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
REDIS_PASSWORD = os.getenv("REDIS_PASSWORD")
DOMAINS_FILE = "domains.txt"
def get_domains_from_file(): #read domains from text file
    if not os.path.exists(DOMAINS_FILE):
        logger.warning(f"File {DOMAINS_FILE} not found. Using defaults.")
        return ["google.com", "github.com"]
    try:
        with open(DOMAINS_FILE, 'r') as f:
            domains = [line.strip() for line in f if line.strip() and not line.startswith("#")]
            return domains
    except Exception as e:
        logger.error(f"Error reading {DOMAINS_FILE}: {e}")
        return []
def get_ssl_expiry(hostname): # check ssl certificate
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
    target_domains = get_domains_from_file()
    if not target_domains:
        logger.error("No domains to check. Exiting.")
        return
    try:
        r = redis.Redis(
            host=REDIS_HOST, 
            port=REDIS_PORT, 
            password=REDIS_PASSWORD, 
            decode_responses=True
        )
        r.ping()
    except Exception as e:
        logger.error(f"Could not connect to Redis: {e}")
        return
    logger.info(f"Starting SSL Check for {len(target_domains)} domains...")
    for domain in target_domains:
        expiry = get_ssl_expiry(domain)
        if expiry:
            days_left = (expiry - datetime.now()).days
            # save to redis
            key = f"ssl_check:{domain}"
            r.set(key, days_left)
            r.expire(key, 86400)
            if days_left < 14:
                logger.warning(f"CRITICAL: {domain} expires in {days_left} days!")
            else:
                logger.info(f"OK: {domain} ({days_left} days remaining).")
if __name__ == "__main__":
    main()