# 🧠 EaseMind – Help From Distance  

Aplicação móvel para **apoio psicológico à distância**, desenvolvida no âmbito da unidade curricular **Programação de Dispositivos Móveis (PDM)**,  
da **Licenciatura em Engenharia Biomédica** do **Instituto Superior de Engenharia de Coimbra (ISEC)**.

---

## 🩺 Visão Geral  

A **EaseMind** é uma aplicação móvel concebida para proporcionar **acompanhamento psicológico remoto**, permitindo aos pacientes escolher a forma de interação mais adequada às suas necessidades e nível de conforto.  
A aplicação pretende **eliminar barreiras emocionais e logísticas** que dificultam o acesso a apoio psicológico, através de três modalidades principais:

- 💬 **Mensagens instantâneas** com o psicólogo;  
- 🎥 **Sessões de vídeo (FaceTime)** em ambiente seguro;  
- 👥 **Consultas presenciais**, sugeridas com base na localização do paciente.

A EaseMind foi desenhada para **acolher especialmente utilizadores mais retraídos**, que podem sentir desconforto em pedir ajuda diretamente, oferecendo uma plataforma intuitiva, empática e inclusiva.

---

## 🎯 Objetivos Principais  

- **Facilitar o acesso a apoio psicológico** através de uma solução digital segura e acessível.  
- **Proporcionar diferentes formas de interação** (mensagens, vídeo ou presença física), respeitando as preferências pessoais.  
- **Promover um ambiente de confiança e empatia**, com foco no bem-estar emocional do utilizador.  
- **Garantir acessibilidade universal**, incluindo suporte a pessoas com limitações visuais, auditivas ou motoras.  

---

## ⚙️ Funcionalidades Detalhadas  

### 🧍‍♀️ Gestão de Perfis  
Cada paciente pode criar um **perfil personalizado** com nome, email, senha e preferências pessoais, incluindo o **género do psicólogo** (feminino/masculino) e a **localização**.  
Estas informações permitem à aplicação **sugerir profissionais próximos** em caso de consultas presenciais.

### 💬 Comunicação e Interação  
A comunicação entre paciente e psicólogo ocorre através de **mensagens de texto seguras**, com possibilidade de **enviar imagens**.  
Para quem prefere contacto mais direto, estão disponíveis **sessões por vídeo** através do FaceTime, bem como **agendamentos de consultas físicas**.

### 📓 Diário Pessoal  
A aplicação inclui um **diário digital** onde o paciente pode escrever livremente sobre o seu estado emocional, pensamentos e experiências.  
O diário é guardado na base de dados e pode ser **consultado pelo psicólogo**, permitindo um acompanhamento mais humanizado e personalizado.

### 📍 Georreferenciação  
A localização do paciente é utilizada para **sugerir psicólogos e clínicas próximas**, facilitando o agendamento de sessões presenciais.  
Esta funcionalidade é opcional e controlada pelo utilizador.

### ☁️ Persistência de Dados  
Todos os dados — perfis, mensagens, sessões e entradas do diário — são armazenados de forma segura na **Cloud Firestore (Firebase)**, garantindo confidencialidade e disponibilidade contínua.

### 🌐 Suporte Multilíngue  
A interface encontra-se disponível em **português** e **inglês**, tornando a aplicação acessível a uma audiência mais ampla.

### 🦾 Acessibilidade e Inclusão  
O design foi pensado para **todos os tipos de utilizadores**, integrando:  
- Compatibilidade com **leitores de ecrã** (TalkBack e VoiceOver);  
- **Navegação por voz** para utilizadores com limitações motoras;  
- **Design adaptado a daltonismo**, com contraste e ícones acessíveis;  
- **Legendas automáticas** durante sessões de vídeo ou áudio.

---

## 🧩 Estrutura de Navegação  

| Ecrã | Descrição | Principais Elementos |
|------|------------|----------------------|
| **Login / Registo** | Página inicial de autenticação | Campos de email e senha, botões “Entrar”, “Criar Conta” e “Esqueci a senha” |
| **Registo de Utilizador** | Criação de perfil e preferências | Nome, email, senha, género do psicólogo, localização |
| **Perfil** | Consulta e atualização de dados pessoais | Preferências, acesso ao diário, notificações e privacidade |
| **Página Principal (Home)** | Hub central da aplicação | Opções de chat, consultas, diário e psicólogos próximos |
| **Chat com Psicólogo** | Comunicação por mensagem | Área de conversa, envio de fotos, botão de envio |
| **Agendamento de Consulta** | Marcação de sessões presenciais | Lista de psicólogos, calendário e confirmação |
| **Diário Pessoal** | Registo emocional do paciente | Campo de texto, histórico de entradas, editar/apagar |
| **Configurações** | Personalização da aplicação | Idioma, notificações, privacidade, logout |
| **Suporte / Ajuda** | Apoio técnico e FAQ | Perguntas frequentes, contacto por email, políticas de privacidade |

---

## 🎨 Design e Experiência do Utilizador  

O protótipo da **EaseMind** foi concebido com base em princípios de **usabilidade, psicologia cognitiva e design emocional**, garantindo uma navegação fluida e intuitiva.

### Paleta de Cores  
- **Tons de verde:** transmitem equilíbrio, harmonia e segurança.  
- **Tons de azul-claro:** evocam serenidade, confiança e relaxamento.  
Esta combinação cria um ambiente **acolhedor, profissional e tranquilizador**, ideal para o contexto psicológico.

### Considerações Cognitivas  
O layout segue uma **hierarquia visual clara**, priorizando elementos essenciais e reduzindo a carga mental.  
Os botões principais (como “Entrar”, “Criar Conta” e “Enviar”) são **visualmente destacados**, guiando o olhar do utilizador.  

### Aplicação das 10 Heurísticas de Nielsen  
O design respeita os princípios clássicos de usabilidade:  
- Visibilidade do estado do sistema;  
- Correspondência com o mundo real;  
- Controlo e liberdade do utilizador;  
- Consistência e conformidade com normas;  
- Prevenção e tratamento de erros;  
- Reconhecimento em vez de memorização;  
- Flexibilidade e eficiência de utilização;  
- Design estético e minimalista;  
- Mensagens de erro claras e construtivas;  
- Documentação e suporte acessíveis.  

---

## 🛠️ Tecnologias Utilizadas  

- **Flutter (Dart)** — desenvolvimento multiplataforma (Android e iOS);  
- **Firebase / Cloud Firestore** — armazenamento de dados em nuvem;  
- **Geolocator** — localização e cálculo de distâncias;  
- **Camera** — envio de imagens;  
- **Provider / Bloc** — gestão de estado (dependendo da implementação).

---
## 👩‍💻 Autora 
Andreia Domingues Fernandes
Licenciatura em Engenharia Biomédica
📧 andreia2000fernandes@gmail.com

