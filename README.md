# FlightHub - iOS App


**[Tela Home]**

<img src="https://i.imgur.com/aTQdMuK.png" width="300" alt="Tela Home">

FlightHub é um aplicativo iOS desenvolvido como parte de um teste técnico para uma vaga de desenvolvimento mobile. O app permite aos usuários gerenciar e visualizar informações sobre voos.

## Características Principais

- Desenvolvido principalmente em ViewCode
- Componente SwiftUI integrado
- Adesão aos princípios SOLID
- Acessibilidade implementada em todo o projeto
- Reatividade através de delegates
- Animações em ViewCode e SwiftUI
- Configuração para uso de mock ou API real
- Extensões úteis para desenvolvimento

## Decisões Técnicas

1. **ViewCode e SwiftUI**: O app foi desenvolvido principalmente em ViewCode, com um componente em SwiftUI para demonstrar a integração entre as duas tecnologias.

2. **SOLID**: Seguido os princípios SOLID para melhorar a manutenibilidade e testabilidade do código.

3. **Acessibilidade**: Implementado recursos de acessibilidade em todo o app para atender usuários com necessidades especiais.

4. **Reatividade**: Utilizado delegates para gerenciar a reatividade do app.

5. **Configuração de Ambiente**: Criado um `APPConfig` para gerenciar o uso de mock ou API real com base na configuração do Xcode Scheme.

6. **Separação de Responsabilidades**: Criado serviços separados para decodificação JSON e gerenciamento de voos.

7. **Customização**: Desenvolvido um `CustomAlert` reutilizável e várias extensões úteis.

8. **Documentação**: As funções foram documentadas seguindo o padrão da Apple, de modo que, ao utilizar a combinação Option + click sobre uma função, os comentários inseridos são exibidos de forma clara e estruturada, semelhante à documentação nativa dos componentes da Apple.

## Como Executar o App

1. Toque no botão "Quero começar" na tela inicial.
2. Na tela de voos, você verá todos os voos disponíveis.
3. Use a barra de pesquisa para filtrar voos por ID.
4. Toque no botão de filtro para abrir as opções de filtro por tipo de voo.
5. Selecione os filtros desejados e toque em "Confirmar".
6. Para limpar os filtros, toque no ícone de borracha.


**[Tela Flights sem filtros]**

<img src="https://i.imgur.com/zJC7Kyo.png" width="300" alt="Tela Flights sem filtros">

## Filtros e Pesquisa

- A pesquisa e os filtros podem ser combinados.
- A cor do ícone do botão de filtro muda quando há algum filtro de status aplicado.
- Scrollar a lista de voos fecha o teclado automaticamente.

**[SearchBar Preenchida]**

<img src="https://i.imgur.com/vO9QAs2.png" width="300" alt="SearchBar Preenchida">

### Filtragem por Status

Você pode filtrar os voos por status usando a subview de filtros:

*[SubView de filtros por status]*

<img src="https://i.imgur.com/8ge8hHd.png" width="300" alt="SubView de filtros por status">

Após aplicar um filtro, a tela de voos será atualizada:

**[Filtro por status aplicado]**

<img src="https://i.imgur.com/kjdkgco.png" width="300" alt="Filtro por status aplicado">

## Instalação

1. Clone o repositório:

   ```bash
   git clone https://github.com/bruunomooura/flighthub.git


2. Abra o arquivo `FlightHub.xcodeproj` no Xcode
3. Selecione o simulador ou dispositivo de destino
4. Execute o app (⌘ + R)
