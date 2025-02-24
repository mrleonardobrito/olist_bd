# Trabalho de Banco de dados: OLIST

## Pré-requisitos

1. Baixe o Git LFS na sua máquina
    - Windows: instale o [arquivo](https://github.com/git-lfs/git-lfs/releases/download/v3.6.1/git-lfs-windows-v3.6.1.exe)
    - Linux (Deb based):

        ```
            curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash | sudo apt-get install git-lfs
        ```

    - Mac:

        ```
            brew install git-lfs
        ```

2. Instale o Git LFS com o comando:

    ```
        git lfs install
    ```

3. Clone o Projeto

4. Instale o docker se não possuir: [(Windows/Mac)](https://docs.docker.com/desktop/setup/install/windows-install/) [(Linux/Mac)](https://docs.docker.com/engine/install/)

## Para rodar o projeto
1. Vá até a pasta raiz do projeto

2. Faça o build da imagem

    ```
    docker build -t olist_db .
    ```

3. Inicie um container a partir da imagem, configurando as variáveis do mysql:

    ```
    docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=olist -e MYSQL_USER=dev -e MYSQL_PASSWORD=1234567 olist_db
    ```
O banco estara disponível no seu host na porta 3306.