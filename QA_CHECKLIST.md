# QA Checklist - ROUBE O OVO

## 🎮 Core Gameplay Loop

### Player Lifecycle
- [ ] Player entra no jogo
- [ ] Spawn na base correta (1-6)
- [ ] Recebe starter egg (COMMON)
- [ ] Starter egg não duplica ao rejoin
- [ ] HUD mostra coins, pets, income corretamente
- [ ] Speed level começa em 0
- [ ] XP bar inicia em 0/100

### Wild Egg Mechanics
- [ ] 6 ovos selvagens spawnam nas áreas
- [ ] Cada guardião protege seu ovo correspondente
- [ ] Ovos têm raridades variadas
- [ ] Visual claramente diferenciado por raridade
- [ ] Player pode identificar raridade sem ler texto
- [ ] Ovos não desaparecem sem motivo

### Steal Mechanics
- [ ] Player seleciona ovo próprio → sem roubar
- [ ] Player seleciona ovo inimigo → prompt ROUBAR
- [ ] Ao roubar: ovo muda visual para "carregando"
- [ ] Ladrão fica ~35% mais lento (verificar velocidade)
- [ ] Dono recebe notificação imediata
- [ ] Servidor valida propriedade antes de permitir
- [ ] Ovo só pode ser roubado se em estado INCUBATING

### Guardian Pursuit
- [ ] Guardião entra em aggro quando ovo é roubado
- [ ] Perseguição é agressiva e constante
- [ ] Guardião não desiste por distância
- [ ] Guardião respeita limites de área
- [ ] Movimento acompanha terreno (raycast funciona)
- [ ] Velocidade de perseguição é apropriada (~1.5 studs/s)
- [ ] Guardião não atravessa paredes/obstáculos

### Escape Zones
- [ ] EscapeZone invisível existe entre corredor e área
- [ ] Guardião para ao jogador cruzar a zona
- [ ] Guardião não atravessa para corredor
- [ ] Feedback visual "ESCAPOU!" aparece
- [ ] Guardião volta ao ninho suavemente (não teleporta)
- [ ] Jogador consegue respirar após escapar

### Drop Mechanics
- [ ] Ovo cai se jogador morre carregando
- [ ] Estado muda para DROPPED
- [ ] Outros podem pegar ovo caído
- [ ] Dono pode recuperar seu próprio ovo
- [ ] Ovo retorna à base original após 30s sem ação
- [ ] Nenhum estado fica preso indefinidamente

### Delivery
- [ ] Zona de entrega está no local correto da base
- [ ] Apenas ladrão pode entregar (validar no servidor)
- [ ] Propriedade transferida corretamente
- [ ] Ovo não pode ser duplicado durante entrega
- [ ] Ovo imediatamente começa incubação nova
- [ ] Notificação "OVO ENTREGUE!" aparece

### Incubation
- [ ] Tempo base respeitado por raridade
- [ ] Upgrades reduzem tempo corretamente (multiplicador)
- [ ] Múltiplos ovos incubam simultaneamente
- [ ] Max 4 slots por base funcionam
- [ ] Ovo não desaparece se base cheia
- [ ] Progresso visual visível no HUD

### Hatching
- [ ] Ovo balança/pisca antes de chocar
- [ ] VFX de casca quebrando aparece
- [ ] Pet spawna com visual correto por raridade
- [ ] Notificação mostra nome da criatura + renda/s
- [ ] Renda começa imediatamente após hatch
- [ ] Pet fica em área correta (PetPlatform)
- [ ] Múltiplos pets hatching simultaneamente funcionam

### Income
- [ ] Renda calculada por segundo
- [ ] Múltiplos pets somam renda corretamente
- [ ] Coins atualizam em tempo real no HUD
- [ ] Income para quando pet/base desaparecer
- [ ] Servidor é autoridade, não cliente
- [ ] Renda não duplica

---

## ⚡ Speed System

### Progression
- [ ] Speed começa em 0
- [ ] XP adicionado ao treinar na esteira
- [ ] 100 XP = 1 nível (confirmado)
- [ ] Max level é 12
- [ ] Nível afeta WalkSpeed corretamente
- [ ] Incremento por nível é consistente (+1.5)

### Training
- [ ] NPC "Teo Turbo" está visível
- [ ] Treadmill é interativo (raycast detecta)
- [ ] XP ganha apenas se se movendo (não AFK)
- [ ] Level up mostra notificação com novo nível
- [ ] UI atualiza speed corretamente
- [ ] XP bar reseta ao subir de nível

### Area Access
- [ ] Speed 0 → Prado acessível (sem erro)
- [ ] Speed 2 → Lago desbloqueado
- [ ] Speed 4 → Deserto desbloqueado
- [ ] Speed 6 → Geleira desbloqueada
- [ ] Speed 8 → Vulcão desbloqueado
- [ ] Speed 11 → Celestial desbloqueado
- [ ] Player pode visitar areas sem speed (sem permitir roubo)

---

## 🛠️ Upgrade System

### Incubator Upgrade
- [ ] Nível 0 (base): sem desconto
- [ ] Nível 1 compra por 1000 coins (85% tempo)
- [ ] Nível 2 compra por 2500 coins (70% tempo)
- [ ] Nível 3 compra por 5000 coins (55% tempo)
- [ ] Nível 4 compra por 10000 coins (40% tempo)
- [ ] Cada nível diminui tempo visualmente
- [ ] Base muda visual com upgrade
- [ ] Max level é 4

### Barrier Upgrade
- [ ] Nível 1 compra por 1500 coins
- [ ] Repele invasor na entrada (push)
- [ ] Não bloqueia permanentemente (pode entrar 2x)
- [ ] Visual aparece na base (cilindro roxo)
- [ ] Efeito dura 3 segundos
- [ ] Max level é 3

### Alarm Upgrade
- [ ] Nível 1 compra por 800 coins
- [ ] Alerta quando base invadida (notificação)
- [ ] Luz pisca visualmente (parte vermelha)
- [ ] Som toca ao ativar (se som ativado)
- [ ] Max level é 2

### Shock Upgrade
- [ ] Nível 1 compra por 1200 coins
- [ ] Ladrão que rouba leva choque
- [ ] Redução de velocidade temporária (multiplicador)
- [ ] VFX elétrico visível (partículas)
- [ ] Duração aumenta por nível (3s → 6s)
- [ ] Max level é 4

---

## 🏪 Shop

### Shop UI
- [ ] Shop abre ao clicar em "Dona Casca"
- [ ] Todos 5 itens aparecem na lista
- [ ] Preços exibem corretamente (999💰 formato)
- [ ] Ícones são claros (emoji ou texture)
- [ ] Botão fechar funciona
- [ ] ESC fecha shop
- [ ] UI responsiva em mobile

### Shop Transactions
- [ ] Random egg custa 300 coins
- [ ] Coins removidos no servidor (validado)
- [ ] Ovo adicionado ao inventário corretamente
- [ ] Upgrades disparam corretamente
- [ ] Erro se coins insuficientes (mensagem clara)
- [ ] Feedback confirmação ao comprar
- [ ] Não pode comprar upgrade max
- [ ] Servidor valida tudo antes de completar

---

## 🎁 Event System

### Rare Egg Event
- [ ] Evento começa automaticamente a cada 45s
- [ ] Dura exatamente 60s
- [ ] Gera ÉPICO, LENDÁRIO, ou MÍTICO aleatório
- [ ] Pedestal mostra contador de tempo
- [ ] Player pode reclamar ovo ao tocar
- [ ] Propriedade transferida corretamente
- [ ] Próximo evento começa sem delay
- [ ] Múltiplos players: primeiro a chegar ganha
- [ ] Notificação aparece ao reclamar

---

## 🗺️ Map Layout

### Structure
- [ ] 6 bases lado a lado (posição correta)
- [ ] Distância visualiza diferenças de riqueza
- [ ] Todos ninhosestão separados de plataformas de pets
- [ ] Corredores existem entre áreas (3 total)
- [ ] Transições são suaves (sem pulos)
- [ ] Sem espaços onde player fica preso

### Area 1 (Prado + Lago)
- [ ] Tema natural claro (cores verdes/azuis)
- [ ] Prado verde vs Lago azul diferenciado
- [ ] Terreno navegável (raycast não falha)
- [ ] Guardiões (Galinha + Sapo) no lugar correto
- [ ] Ovo selvagem visível em cada área

### Area 2 (Deserto + Geleira)
- [ ] Transição deserto → gelo visível
- [ ] Terreno mais desafiador (obstáculos presentes)
- [ ] Guardiões (Escorpião + Golem) corretos
- [ ] Ovo selvagem em cada área
- [ ] Cores diferenciadas (laranja/branco)

### Area 3 (Vulcão + Celestial)
- [ ] Tema épico/raro implementado
- [ ] Vulcão com visual de lava (cor vermelha)
- [ ] Celestial com efeitos (cor ciano)
- [ ] Mais elevação/terreno complexo
- [ ] Guardiões poderosos (Lagarto + Criatura Astral)
- [ ] Ovo selvagem em cada área

---

## 💾 DataStore

### Studio
- [ ] Dados temporários por padrão (não persistent)
- [ ] Sem erro se place não publicado
- [ ] EnableStudioDataStore = false/true funcionando

### Published Server
- [ ] DataStore carrega ao join
- [ ] Dados salvos ao sair
- [ ] Auto-save a cada 30s
- [ ] Nenhuma perda de dados
- [ ] Coins persistem
- [ ] Upgrades persistem
- [ ] Speed level persiste
- [ ] Pet IDs persistem

---

## 👥 Multiplayer

### Two Players Test
- [ ] Player A tem ovo
- [ ] Player B consegue roubar
- [ ] A vê notificação de roubo
- [ ] B consegue fugir do guardião
- [ ] A consegue recuperar ovo
- [ ] B consegue entregar ovo
- [ ] Propriedade muda para B corretamente

### Disconnects
- [ ] A carregando ovo → A sai
  - [ ] Ovo cai em local apropriado
  - [ ] Ninguém fica preso com ovo
  - [ ] B pode recuperar
- [ ] B perseguindo A → B sai
  - [ ] Guardião retorna ao ninho
  - [ ] A não fica perseguido indefinidamente

### Simultaneous Actions
- [ ] Dois steals simultâneos?
  - [ ] Um sucede, outro falha
  - [ ] Fila é respeitada
- [ ] Duas compras simultâneas?
  - [ ] Uma falha se sem coins
  - [ ] Outra sucede
- [ ] Two players em mesmo ovo?
  - [ ] Apenas um consegue roubar

---

## 🛡️ Edge Cases

- [ ] Base cheia (4 ovos) → novo compra
  - [ ] Erro claro "Base cheia"
  - [ ] Coins não removidos
- [ ] Owner disconnect com ovo carregado
  - [ ] Ovo cai e fica recuperável
  - [ ] Criatura não permanece flutuando
- [ ] Hatch durante roubo
  - [ ] Criatura não afeta o roubo
  - [ ] Ovo roubável normalmente
- [ ] Guardian sem chão
  - [ ] Raycast falha graciosamente
  - [ ] Guardian não flutua indefinidamente
  - [ ] Guardian retorna ao ninho
- [ ] Guardian preso entre objetos
  - [ ] Timeout → retorna automaticamente
  - [ ] Nunca trava o jogo
- [ ] Ovo evento expirando
  - [ ] Se carregado, muda para INCUBATING
  - [ ] Sem perda de propriedade
- [ ] Player resetando character
  - [ ] Character novo spawna
  - [ ] Dados são preservados
  - [ ] Speed mantido
  - [ ] Ovo não é perdido

---

## 🎨 UI/UX

### HUD
- [ ] Coins visível (canto superior esquerdo)
- [ ] Pets contados corretamente
- [ ] Income/s mostra número correto
- [ ] Speed level mostra número 0-12
- [ ] XP barra progride visualmente
- [ ] Nenhum overlap com gameplay
- [ ] Texto legível em todas as resoluções

### Notifications
- [ ] Aparecem rapidamente (< 100ms)
- [ ] Desaparecem sem entulho (garbage collected)
- [ ] Cores diferenciadas (sucesso verde, erro vermelho)
- [ ] Texto legível
- [ ] Não spamam (máximo 2 simultâneos)
- [ ] Fade out suave (não cortado)

### Mobile
- [ ] Botões acessíveis com dedo (tamanho > 40px)
- [ ] UI escala corretamente (responsiva)
- [ ] Texto legível em telas pequenas (sem cut off)
- [ ] Prompts funcionam no mobile
- [ ] Touch input detectado

---

## ⚡ Performance

- [ ] FPS estável 60+ em PC
- [ ] FPS 30+ em mobile (não travando)
- [ ] Sem lag ao roubar múltiplos ovos
- [ ] Múltiplos guardiões não travam
- [ ] 6 bases + 3 áreas sem lag
- [ ] Evento com 10+ players ainda responsivo
- [ ] Sem memory leaks (verificar com DevConsole)
- [ ] Load time < 5s para novo player

---

## 🎨 Visual Polish

- [ ] Mapa parece Roblox clássico?
- [ ] Bases têm identidade visual clara?
- [ ] Guardiões parecem vivos (não partes soltas)?
- [ ] VFX complementam sem exagerar?
- [ ] Cores diferem claramente por área?
- [ ] Ovos e pets escalados proporcionalmente?
- [ ] Sem texturas faltantes
- [ ] Sem partes clipping

---

## 🔒 Security

- [ ] Nenhum TODO/FIXME no código crítico
- [ ] Todos os comentários são úteis
- [ ] Código formatado e legível
- [ ] Configs centralizados (não hardcoded)
- [ ] Services independentes (baixo acoplamento)
- [ ] Anti-exploit implementado
  - [ ] Validação servidor-side
  - [ ] Sem dados críticos no cliente
  - [ ] Distância verificada
  - [ ] Propriedade validada
- [ ] Diagnostics funcionando

---

## 📝 Documentation

- [ ] README.md completo e atualizado
- [ ] CHANGELOG.md com todas as mudanças
- [ ] QA_CHECKLIST.md este arquivo
- [ ] Código comentado em pontos críticos
- [ ] Configs bem nomeados e explicados
- [ ] Estrutura de pastas lógica

---

## ✅ Final Checklist

- [ ] Todas as mecânicas testadas
- [ ] Todos os sistemas funcionam
- [ ] Nenhum crash ou erro
- [ ] Performance aceitável
- [ ] UI clara e responsiva
- [ ] Multiplayer estável
- [ ] DataStore persistindo
- [ ] Anti-exploit efetivo
- [ ] Documentação completa
- [ ] Ready for beta launch! 🚀

---

**Data de Criação:** 31/08/2026
**Versão:** QA v1.0
**Status:** ✨ Pronto para Testes
