# Clean Architeture com Delphi

## 🚀 Sobre o projeto

Este projeto foi desenvolvido durante o curso [Aplicando clean architecture com Delphi](https://www.udemy.com/course/aplicandocleanarchitecturecomdelphi), que tem como objetivo aplicar de forma prática os princípios da [Arquitetura Limpa](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) utilizando a linguagem de programação Delphi.

## ⚙️ Funcionalidades

Trata-se de um projeto que busca representar o domínio de um sistema de Locação de Veículos, onde o usuário pode cadastrar Clientes, Veículos e Locações.

O projeto é composto de duas aplicações, uma console e outra uma API desenvolvida com [Horse](https://github.com/HashLoad/horse).

Contudo, ambas as aplicações consome um mesmo "Core", através da aplicações dos princípios da Arquitetura Limpa.

Existe também uma aplicação para testar de forma simples as principais classes do "Core".

## 🛠️ Tecnologias

As seguintes ferramentas foram utilizadas na construção do projeto:

### Liguagem de programação e IDE

- [Delphi 11.3 Alexandria Community](https://www.embarcadero.com/br/products/rad-studio/whats-new-in-11-alexandria).
- [MMX](https://www.mmx-delphi.de/) (Ferramenta com atalhos pra acelerar o desenvolvimento no Delphi)

### Construção da API

- [Horse](https://github.com/HashLoad/horse).
- [Postman](https://www.postman.com/) (utilizada para teste das rotas).

### Implementação dos testes

- [DUnitX](https://github.com/VSoftTechnologies/DUnitX).
- [TestInsight](https://bitbucket.org/sglienke/testinsight/wiki/Home) (ferramenta para visualização gráfica dos resultados de testes)

### Banco de Dados

- [Firebird 2.5](https://firebirdsql.org/en/firebird-2-5/).
- [IBExpert Personal Edition](https://www.ibexpert.net/).

### Versionamento

- [Git](https://git-scm.com/).
- [Github](https://github.com/).
- [Github Desktop](https://desktop.github.com/).

## Configurando o projeto

<details>
    <summary>
        Instalação e Configuração do Delphi
    </summary>

1. Acesse o [site oficial da Embarcadero](https://www.embarcadero.com/products/delphi/starter/free-download).
2. Crie uma conta.
3. Faça o download da última versão disponível do Delphi Community.
4. Relize a instalação e registre o produto.
5. Faça download do wizard e instale o [Horse](https://github.com/HashLoad/horse).
6. Faça download do wizard e instale o [MMX](https://www.mmx-delphi.de/downloads/).
7. Faça download do wizard e instale o [TestInsight](https://files.spring4d.com/TestInsight/latest/TestInsightSetup.zip).
   
</details>

<details>
    <summary>
        Instalação do Postman
    </summary>

1. Baixe o Postman pelo [site oficial](https://www.postman.com/downloads/).
2. Poderá ser necessário criar uma conta.
3. Instale e configure o Postman no computador.

</details>

<details>
    <summary>
        Configuração do Banco de Dados
    </summary>

1. Faça download da versão 2.5 do Firebird no [site oficial](https://firebirdsql.org/en/firebird-2-5/).
2. Instale o Firebird em sua máquina.
3. Também faça a instalação de alguma ferramenta de interface gráfica para administração de bancos Firebird, como o [IBExpert na versão gratuita](https://www.ibexpert.net/downloadcenter/).
4. Acesse o arquivo de Aliases do Firebird, geralmente localizado em `C:\Program Files\Firebird\Firebird_2_5\aliases.conf`, e configure uma banco com o alias LOCACAO.

</details>

<details>
    <summary>
        Clonando e Configurando o Projeto
    </summary>

1. Clone o projeto executando o seguinte comando no terminal:

```batch
git clone https://github.com/SauloJCF/clean-architeture-delphi.git
```

2. Execute o arquivo `.\clean-architeture-delphi\Script\create-database.sql` no IBExpert (ou qualquer outra ferramenta de gerenciamento de banco de dados de preferência), para criar o banco de dados.
3. Importe o arquivo `.\clean-architeture-delphi\Postman\clean-architeture-delphi.postman_collection.json` no Postman.
4. Abra o arquivo `\clean-architeture-delphi\Applications\GroupLocacao.groupproj` com Delphi (**File >> Open Project**).
5. Execute o projeto **LocacaoConsole**, para abrir a aplicação console.
6. Execute o projeto **LocacaoAPI**, para iniciar a API.
7. Execute o projeto **LocacaoTeste** para rodar os testes do projeto.

</details>