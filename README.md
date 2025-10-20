# 🧠 EaseMind – Ajuda à Distância  

Aplicação móvel para **apoio psicológico à distância**, desenvolvida no âmbito da unidade curricular **Programação de Dispositivos Móveis (PDM)**,  
da **Licenciatura em Engenharia Biomédica** do **Instituto Superior de Engenharia de Coimbra (ISEC)**.

---

## 🩺 Visão Geral  

A **EaseMind** é uma aplicação móvel concebida para proporcionar **acompanhamento psicológico remoto**, permitindo a cada paciente escolher a forma de interação mais adequada às suas necessidades e nível de conforto.  
A aplicação pretende **eliminar barreiras emocionais e logísticas** que dificultam o acesso a apoio psicológico, oferecendo três modalidades principais:

- 💬 **Mensagens instantâneas** com o psicólogo;  
- 🎥 **Sessões por vídeo (FaceTime)** em ambiente seguro;  
- 👥 **Consultas presenciais**, sugeridas com base na localização do paciente.

A EaseMind foi desenhada para **acolher especialmente pessoas mais reservadas**, que possam sentir desconforto em pedir ajuda diretamente, disponibilizando uma plataforma intuitiva, empática e inclusiva.

---

## 🎯 Objetivos Principais  

- **Facilitar o acesso a apoio psicológico** através de uma solução digital segura e acessível;  
- **Disponibilizar diferentes formas de interação** (mensagens, vídeo ou presença física), respeitando as preferências individuais;  
- **Promover um ambiente de confiança e empatia**, centrado no bem-estar emocional da pessoa;  
- **Garantir acessibilidade universal**, incluindo suporte para pessoas com limitações visuais, auditivas ou motoras.  

---

## ⚙️ Funcionalidades Detalhadas  

### 🧍‍♀️ Gestão de Perfis  
Cada paciente pode criar um **perfil personalizado** com nome, email, palavra-passe e preferências pessoais, incluindo o **género do psicólogo** (feminino/masculino) e a **localização**.  
Estas informações permitem à aplicação **sugerir profissionais próximos**, no caso de consultas presenciais.

### 💬 Comunicação e Interação  
A comunicação entre paciente e psicólogo é realizada através de **mensagens de texto seguras**, com possibilidade de **enviar imagens**.  
Para quem prefere contacto mais direto, estão disponíveis **sessões por vídeo** através do FaceTime, bem como **agendamentos de consultas presenciais**.

### 📓 Diário Pessoal  
A aplicação inclui um **diário digital** onde o paciente pode registar livremente o seu estado emocional, pensamentos e experiências.  
O diário é armazenado na base de dados e pode ser **consultado pelo psicólogo**, permitindo um acompanhamento mais humanizado e personalizado.

### 📍 Georreferenciação  
A localização do paciente é utilizada para **sugerir psicólogos e clínicas próximas**, facilitando o agendamento de sessões presenciais.  
Esta funcionalidade é opcional e totalmente controlada pela pessoa.

### ☁️ Armazenamento de Dados  
Todos os dados — perfis, mensagens, sessões e entradas do diário — são guardados de forma segura na **Cloud Firestore (Firebase)**, garantindo confidencialidade e disponibilidade contínua.

### 🌐 Suporte Multilíngue  
A interface está disponível em **português** e **inglês**, tornando a aplicação acessível a um público mais vasto.

### 🦾 Acessibilidade e Inclusão  
O design foi concebido para **todos os tipos de utilizadores**, integrando:  
- Compatibilidade com **leitores de ecrã** (TalkBack e VoiceOver);  
- **Navegação por voz** para pessoas com limitações motoras;  
- **Design adaptado ao daltonismo**, com contraste e ícones acessíveis;  
- **Legendas automáticas** durante as sessões de vídeo ou áudio.

---

## 🧩 Estrutura de Navegação  

| Ecrã | Descrição | Principais Elementos |
|------|------------|----------------------|
| **Login / Registo** | Página inicial de autenticação | Campos de email e palavra-passe, botões “Entrar”, “Criar Conta” e “Esqueci a palavra-passe” |
| **Registo de Conta** | Criação de perfil e preferências | Nome, email, palavra-passe, género do psicólogo, localização |
| **Perfil** | Consulta e atualização de dados pessoais | Preferências, acesso ao diário, notificações e privacidade |
| **Página Principal (Home)** | Ecrã central da aplicação | Opções de chat, consultas, diário e psicólogos próximos |
| **Chat com Psicólogo** | Comunicação por mensagem | Área de conversa, envio de fotos, botão de envio |
| **Agendamento de Consulta** | Marcação de sessões presenciais | Lista de psicólogos, calendário e confirmação |
| **Diário Pessoal** | Registo emocional do paciente | Campo de texto, histórico de entradas, editar/apagar |
| **Definições** | Personalização da aplicação | Idioma, notificações, privacidade, terminar sessão |
| **Suporte / Ajuda** | Apoio técnico e FAQ | Perguntas frequentes, contacto por email, políticas de privacidade |

---

## 🎨 Design e Experiência do Utilizador  

O protótipo da **EaseMind** foi concebido com base em princípios de **usabilidade, psicologia cognitiva e design emocional**, garantindo uma navegação fluida e intuitiva.

### Paleta de Cores  
- **Tons de verde:** transmitem equilíbrio, harmonia e segurança;  
- **Tons de azul-claro:** evocam serenidade, confiança e relaxamento.  

Esta combinação cria um ambiente **acolhedor, profissional e tranquilizador**, ideal para o contexto psicológico.

### Considerações Cognitivas  
O layout segue uma **hierarquia visual clara**, priorizando os elementos essenciais e reduzindo a carga cognitiva.  
Os botões principais (como “Entrar”, “Criar Conta” e “Enviar”) são **visualmente destacados**, orientando o olhar da pessoa.

### Aplicação das 10 Heurísticas de Nielsen  
O design respeita os princípios clássicos de usabilidade:  
- Visibilidade do estado do sistema;  
- Correspondência com o mundo real;  
- Controlo e liberdade da pessoa;  
- Consistência e conformidade com normas;  
- Prevenção e recuperação de erros;  
- Reconhecimento em vez de memorização;  
- Flexibilidade e eficiência de utilização;  
- Design estético e minimalista;  
- Mensagens de erro claras e construtivas;  
- Documentação e suporte acessíveis.  

---

## 🛠️ Tecnologias Utilizadas  

- **Flutter (Dart)** — desenvolvimento multiplataforma (Android e iOS);  
- **Firebase / Cloud Firestore** — armazenamento de dados na nuvem;  
- **Geolocator** — localização e cálculo de distâncias;  
- **Camera** — envio de imagens;  
- **Provider / Bloc** — gestão de estado (dependendo da implementação).

---

## 👩‍💻 Autora  

**Andreia Domingues Fernandes**  
Licenciatura em Engenharia Biomédica  
📧 andreia2000fernandes@gmail.com  

