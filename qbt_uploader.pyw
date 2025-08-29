import sys
import requests
import os
import logging
from logging.handlers import RotatingFileHandler

# --- CONFIGURAÇÃO DO SCRIPT ---
QBIT_URL = "seu-dominio.com:8080" # SEU DOMÍNIO ou IP do qBittorrent, SEM http://
QBIT_USERNAME = "seu_usuario"
QBIT_PASSWORD = "sua_senha"
VERIFY_SSL_CERT = True # Mude para False se usar um certificado SSL auto-assinado
# --- FIM DA CONFIGURAÇÃO DO SCRIPT ---

# --- CONFIGURAÇÃO DO LOG --- 
log_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'qbt_uploader.log')
log_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
# Rotação de Log: 1MB por arquivo, mantendo até 5 arquivos antigos.
log_handler = RotatingFileHandler(log_file, maxBytes=1*1024*1024, backupCount=5, encoding='utf-8')
log_handler.setFormatter(log_formatter)
logger = logging.getLogger()
logger.setLevel(logging.INFO)
logger.addHandler(log_handler)
# --- FIM DA CONFIGURAÇÃO DO LOG ---

def upload_torrent(torrent_path):
    if not os.path.exists(torrent_path):
        logging.error(f"Arquivo não encontrado: '{torrent_path}'") # <<< ALTERADO
        return

    session = requests.Session()
    
    if not VERIFY_SSL_CERT:
        from urllib3.exceptions import InsecureRequestWarning
        requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

    try:
        logging.info(f"Iniciando processo para o torrent: {os.path.basename(torrent_path)}") # <<< ALTERADO

        # 1. Autenticar
        login_payload = {'username': QBIT_USERNAME, 'password': QBIT_PASSWORD}
        login_url = f"https://{QBIT_URL}/api/v2/auth/login"
        
        logging.info("Tentando fazer login...") # <<< ALTERADO
        response = session.post(login_url, data=login_payload, verify=VERIFY_SSL_CERT, timeout=10)
        
        if response.status_code != 200 or "SID" not in session.cookies:
            logging.error(f"Falha no login! Status: {response.status_code}. Resposta: {response.text}") # <<< ALTERADO
            return

        logging.info("Login realizado com sucesso!") # <<< ALTERADO

        # 2. Fazer o upload do arquivo
        upload_url = f"https://{QBIT_URL}/api/v2/torrents/add"
        
        with open(torrent_path, 'rb') as f:
            files = {'torrents': (os.path.basename(torrent_path), f, 'application/x-bittorrent')}
            
            # Opções de Adição
            data = {
                'paused': 'true',
                'savepath': '/downloads/Temp' # Caminho da pasta no SERVIDOR/DOCKER
            }
            
            logging.info(f"Enviando arquivo para a pasta '{data['savepath']}' (pausado)...") # <<< ALTERADO
            upload_response = session.post(upload_url, files=files, data=data, verify=VERIFY_SSL_CERT, timeout=30)

            if upload_response.status_code == 200:
                logging.info(f"Torrent '{os.path.basename(torrent_path)}' adicionado com sucesso!") # <<< ALTERADO
            else:
                logging.error(f"Falha ao adicionar torrent! Status: {upload_response.status_code}. Resposta: {upload_response.text}") # <<< ALTERADO

    except requests.exceptions.RequestException as e:
        # Usar logging.exception anexa o traceback completo do erro ao log, o que é ótimo para depuração
        logging.exception(f"Ocorreu um erro de conexão: {e}") # <<< ALTERADO
    except Exception as e:
        logging.exception(f"Ocorreu um erro inesperado: {e}") # <<< ALTERADO

if __name__ == "__main__":
    if len(sys.argv) > 1:
        torrent_file_path = sys.argv[1]
        upload_torrent(torrent_file_path)
    else:
        # Se o script for executado sem um arquivo, isso será registrado.
        logging.warning("Script executado sem fornecer um arquivo torrent como argumento.")

# A linha de pausa foi removida permanentemente. O script agora fecha sozinho.