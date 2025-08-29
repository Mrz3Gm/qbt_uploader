# qBit-Click-Uploader ✨

Adicione torrents ao seu qBittorrent Web UI com um simples clique duplo, de forma silenciosa e automática.

![Demo](https://i.imgur.com/8Yl1wfl.png) ## 📖 Sobre o Projeto

Cansado de ter que abrir o navegador, fazer login, clicar em "Adicionar Arquivo" e navegar pelas pastas toda vez que baixa um arquivo `.torrent`?

Este projeto automatiza todo esse processo. Uma vez configurado, você pode simplesmente dar um clique duplo em qualquer arquivo `.torrent` no seu computador, e o script irá, silenciosamente em segundo plano:

1.  Autenticar na sua interface web do qBittorrent.
2.  Enviar o arquivo `.torrent`.
3.  Adicioná-lo à sua lista de downloads, já pausado e em uma pasta pré-definida.
4.  Registrar todo o processo em um arquivo de log para fácil depuração.

É uma solução "clique e esqueça" que otimiza completamente o fluxo de trabalho para quem usa o qBittorrent em um servidor.

## 🚀 Funcionalidades

* **Integração Total:** Associa-se à extensão `.torrent` do seu sistema operacional.
* **Execução Silenciosa:** Sem janelas de terminal aparecendo durante o processo.
* **Altamente Configurável:** Defina a pasta de destino padrão e se os torrents devem começar pausados.
* **Sistema de Log:** Mantém um registro de todas as operações e erros em um arquivo `qbt_uploader.log`.
* **Portátil:** O script pode ser colocado em qualquer pasta, facilitando a organização.

## 🔧 Começando

Siga os passos abaixo para configurar e começar a usar a ferramenta.

### Pré-requisitos

* **qBittorrent com a Interface Web Ativada:** Você precisa ter acesso ao seu qBittorrent pelo navegador.
* **Python 3:** Instalado na sua máquina local (o computador onde você clica nos torrents).
    * Você pode baixar em [python.org](https://www.python.org/downloads/). Durante a instalação no Windows, marque a caixa "Add Python to PATH".
* **Biblioteca `requests`:** Para instalar, abra um terminal (CMD ou PowerShell) e execute:
    ```sh
    pip install requests
    ```

### Instalação e Configuração

1.  **Baixe os Arquivos:**
    * Faça o download dos arquivos `qbt_uploader.pyw` e `run_qbt_uploader.bat` deste repositório e coloque ambos na mesma pasta em seu computador.

2.  **Configure o Script `qbt_uploader.pyw`:**
    * Abra o arquivo `qbt_uploader.pyw` com um editor de texto (como Bloco de Notas, VS Code, etc.).
    * Edite a seção `--- CONFIGURAÇÃO DO SCRIPT ---` com seus dados:

    ```python
    # --- CONFIGURAÇÃO DO SCRIPT ---
    QBIT_URL = "seu-dominio.com:8080" # SEU DOMÍNIO ou IP do qBittorrent, SEM http://
    QBIT_USERNAME = "seu_usuario"
    QBIT_PASSWORD = "sua_senha"
    VERIFY_SSL_CERT = True # Mude para False se usar um certificado SSL auto-assinado
    # --- FIM DA CONFIGURAÇÃO DO SCRIPT ---
    ```
    * Na mesma tela, ajuste as opções de download como preferir:
    ```python
    # Opções de Adição
    data = {
        'paused': 'true',               # 'true' para adicionar pausado, 'false' para iniciar imediatamente
        'savepath': '/downloads/Temp'   # Caminho da pasta de destino DENTRO DO SERVIDOR/DOCKER
    }
    ```
    * Salve o arquivo após as alterações.

3.  **Associe a Extensão `.torrent` (Windows):**
    * Encontre qualquer arquivo `.torrent` no seu computador.
    * Clique com o botão direito sobre ele e vá em `Abrir com > Escolher outro aplicativo`.
    * Role para baixo, clique em `Mais aplicativos` e depois em `Procurar outro aplicativo neste PC`.
    * Navegue até a pasta onde você salvou os scripts e selecione o arquivo `run_qbt_uploader.bat`.
    * **Importante:** Marque a caixa "Sempre usar este aplicativo para abrir arquivos .torrent".
    * Clique em "OK".

## ✨ Uso

Após a configuração, o uso é incrivelmente simples:

* **Dê um clique duplo em qualquer arquivo `.torrent`!**

É isso. Nenhuma janela aparecerá. Em alguns segundos, o torrent será adicionado à sua lista no qBittorrent Web UI. Se algo der errado, verifique o arquivo `qbt_uploader.log` que será criado na mesma pasta dos scripts.

## 🐧 Para Usuários de Linux/macOS

O script Python (`.pyw` deve ser renomeado para `.py`) é multiplataforma. O que muda é o "executor". Em vez do `.bat`, você pode criar um script de shell (`.sh`).

1.  **Crie um arquivo `run_uploader.sh`** com o seguinte conteúdo:
    ```sh
    #!/bin/bash
    # O caminho para o python pode variar. Use 'which python3' para encontrar.
    # O caminho para o script deve ser absoluto.
    /usr/bin/python3 "/caminho/completo/para/qbt_uploader.py" "$1"
    ```
2.  **Torne-o executável:**
    ```sh
    chmod +x run_uploader.sh
    ```
3.  **Associe a extensão `.torrent`** ao seu script `run_uploader.sh` através das configurações do seu ambiente de desktop (GNOME, KDE, etc.).

## 📜 Licença

Distribuído sob a Licença MIT. Veja o arquivo `LICENSE` para mais informações.
