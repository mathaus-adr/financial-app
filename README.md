# financialweb
Integrantes:
Mathaus Adorno Pereira

O financial web é um app que facilita a divisão de valores entre participantes de uma certa atividade como por exemplo uma viagem que possui custos referentes a hospedagem, alimentação, combustível e afins. O app resolve o problema de dividir o custo total entre os participantes caso mais de um participante contribuíram para o valor total, facilitando as contas entre os participantes.


Funcionalidades:
 - Participantes
    - Cadastro de participantes
    - Busca de participantes

 - Contas
    - Cadastro da conta
    - Vínculo do participante pagador da conta
    - Vínculo de atividade

 - Cadastro de atividade
   - Vínculo dos participantes da atividade
   - Vínculo das contas em cima de uma atividade
   - Fechamento da atividade com os devidos valores para os participantes
   - Edição de quem entra ou sai da atividade (contas e participantes) 

 - Exibição dos valores a pagar de cada participante para o recebedor 
  - Por exemplo se o valor total de uma atividade executada pelos participantes for de R$ 1000 e temos 3 participantes.
   - Participante 1 pagou R$ 700
   - Participante 2 pagou R$ 200
   - Participante 3 pagou R$ 100
   - Temos o valor total de R$ 333,33 para cada participante
   - Logo o participante 2 deve enviar R$ 133,33 ao participante 1 e o Participante 3 deve enviar R$ 233,33 para o participante 1
   - Essencial para casos onde há vários participantes e várias contas em uma determinada atividade (churrasco)
 - Dependências
  - Hive
  - Intl
- Parte 1
  - UI
    - Barra de navegação inferior
        - [x] Botões para cadastro de participante, Botões para atividades, Botões para cadastro de contas
    - Listagem das atividades (Home)
        - [ ] View que mostra detalhes de quem participou da atividade, valor total, assim como lista dos valores a serem pagos pelos participantes e os valores que ja foram pagos
    - [ ] Detalhes da atividade
      - [ ] Contas envolvidas na atividade (edição)
      - [ ] Participantes envolvidos (edição)
      - [ ] Fechamento da atividade  
  - Validações em formulários
    - [x] Cadastro de participante
    - [x] Cadastro de atividade
    - [x] Cadastro de conta


- Parte 2
  - Mudar a navbar para responder aos eventos
  - Utilizar com base na listagem de eventos 