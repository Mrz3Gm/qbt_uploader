# qBit-Click-Uploader 

Adicione torrents ao seu qBittorrent Web UI com um simples clique duplo, de forma silenciosa e automática.

## Sobre o Projeto

Cansado de ter que abrir o navegador, fazer login, clicar em "Adicionar Arquivo" e navegar pelas pastas toda vez que baixa um arquivo `.torrent`?

Este projeto automatiza todo esse processo. Uma vez configurado, você pode simplesmente dar um clique duplo em qualquer arquivo `.torrent` no seu computador, e o script irá, silenciosamente em segundo plano:

1.  Autenticar na sua interface web do qBittorrent.
2.  Enviar o arquivo `.torrent`.
3.  Adicioná-lo à sua lista de downloads, já pausado e em uma pasta pré-definida.
4.  Registrar todo o processo em um arquivo de log para fácil depuração.
5.  Atribuir um ícone personalizado e exclusivo aos arquivos `.torrent`, sem afetar outros tipos de arquivo.

É uma solução "clique e esqueça" que otimiza completamente o fluxo de trabalho para quem usa o qBittorrent em um servidor.

## Funcionalidades

* **Integração Total:** Cria uma associação de arquivo personalizada e exclusiva para a extensão `.torrent`.
* **Execução Silenciosa:** Nenhuma janela de terminal aparece durante o processo.
* **Altamente Configurável:** Defina a pasta de destino padrão e se os torrents devem começar pausados.
* **Ícone Personalizado:** Define um ícone exclusivo para arquivos `.torrent`.
* **Sistema de Log:** Mantém um registro de todas as operações e erros em um arquivo `qbt_uploader.log`.
* **Portátil:** Todos os scripts podem ser colocados em qualquer pasta.

##  Começando

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
    * Faça o download de **todos** os arquivos deste repositório e coloque-os **na mesma pasta** no seu computador. Os arquivos essenciais são:
        * `qbt_uploader.pyw`
        * `run_qbt_uploader.bat`
        * `Configurar_Associacao_Completa.bat`
        * `ibittorrent.ico`

2.  **Configure o Script `qbt_uploader.pyw`:**
    * Abra o arquivo `qbt_uploader.pyw` com um editor de texto.
    * Edite a seção `--- CONFIGURAÇÃO DO SCRIPT ---` com seus dados:

    ```python
    # --- CONFIGURAÇÃO DO SCRIPT ---
    QBIT_URL = "seu-dominio.com:8080" # SEU DOMÍNIO ou IP do qBittorrent, SEM http://
    QBIT_USERNAME = "seu_usuario"
    QBIT_PASSWORD = "sua_senha"
    VERIFY_SSL_CERT = True # Mude para False se usar um certificado SSL auto-assinado
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

3.  **Execute o Configurador Automático:**
    * Clique com o botão direito no arquivo `Configurar_Associacao_Completa.bat` e selecione **"Executar como administrador"**.
    * Siga as instruções na tela e confirme a operação. Este script fará tudo: criará o novo tipo de arquivo, definirá o ícone e associará a extensão `.torrent`.
    * **Reinicie o seu computador** para garantir que todas as alterações sejam aplicadas.

##  Uso

Após a configuração, o uso é incrivelmente simples:

* **Dê um clique duplo em qualquer arquivo `.torrent`!**

É isso. O torrent será adicionado silenciosamente ao seu qBittorrent.

##  Solução de Problemas (Troubleshooting)

Encontrou um problema? Veja as soluções para os casos mais comuns.

### Torrents não iniciam pausados

Se os torrents começam a baixar imediatamente, mesmo com a opção `'paused': 'true'` no script, o problema é uma configuração no seu qBittorrent que está se sobrepondo ao comando da API.

**Solução:**
1.  Na interface web do qBittorrent, vá em **Ferramentas > Opções > Downloads**.
2.  Na seção **"Ao adicionar um torrent"**, marque a caixa **"Não iniciar o download automaticamente"**.
3.  Clique em **Salvar**.

![Configuração do qBittorrent](https://i.imgur.com/xJASSVW.png)


### O ícone personalizado do `.torrent` não aparece

Às vezes, o Windows pode ser teimoso e não exibir o novo ícone, mesmo após reiniciar. Isso é causado por um cache de ícones "preso".

**Solução 1: Limpar o Cache de Ícones (Automático)**
1.  Execute o script `Limpar_Cache_Icones.bat` (incluído no repositório) como administrador.
2.  Sua tela irá piscar (a barra de tarefas vai desaparecer e voltar), o que é normal.
3.  Verifique se o ícone foi corrigido.

**Solução 2: Forçar a Atualização com FileTypesMan (Definitivo)**
Se a limpeza de cache não funcionar, esta ferramenta gratuita e poderosa resolverá o problema.

1.  Baixe o **FileTypesMan (versão 64-bit)** do site oficial: [https://www.nirsoft.net/utils/file_types_manager.html](https://www.nirsoft.net/utils/file_types_manager.html)
2.  Descompacte o arquivo `.zip` e execute `FileTypesMan.exe`.
3.  Na lista, encontre a extensão `.torrent` e dê um duplo clique nela.
4.  No campo `Ícone Padrão`, clique no botão `...` e selecione manualmente o arquivo `ibittorrent.ico` da sua pasta de scripts.
5.  Clique em "OK" para salvar.
6.  No menu superior do FileTypesMan, vá em **Options > Refresh System Icons Now**. Isso força o Windows a recarregar todos os ícones imediatamente.

##  Licença

Distribuído sob a Licença MIT. Veja o arquivo `LICENSE` para mais informações.
