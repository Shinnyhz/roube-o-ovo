# ROUBE O OVO - Documentação Completa

## Visão Geral

**ROUBE O OVO** é um jogo multiplayer social de Roblox onde os jogadores:
- 🥚 Incubam ovos em suas bases
- 🔓 Roubam ovos de outros jogadores
- 🛡️ Protegem suas bases contra invasores
- 🏃 Escapam de guardiões poderosos
- 🐾 Fazem evoluir criaturas (pets) para gerar renda
- ⚡ Progridem através de upgrades e speed levels

## 📋 Estrutura do Projeto

### Configurações Centralizadas (`src/ReplicatedStorage/Shared/`)

- **GameConfig.luau** - Configurações globais do jogo
- **EggConfig.luau** - Raridades, stats e mecânicas de ovos
- **CreatureConfig.luau** - Definições dos pets
- **AreaConfig.luau** - Mapa, áreas e spots selvagens
- **UpgradeConfig.luau** - Upgrades e seus efeitos
- **ShopConfig.luau** - Itens da loja
- **SoundConfig.luau** - Efeitos sonoros

### Serviços do Servidor (`src/ServerScriptService/Services/`)

**Core Services:**
- `DataService` - Persistência de dados (DataStore)
- `MapService` - Construção do mapa
- `BaseService` - Gerenciamento de bases
- `EggService` - Ciclo de vida dos ovos
- `CreatureService` - Criação de pets
- `EconomyService` - Geração de renda
- `SpeedService` - Progressão de velocidade
- `UpgradeService` - Sistema de upgrades
- `ShopService` - Transações da loja
- `DiagnosticsService` - Validação

**Advanced Services:**
- `GuardianService` - Guardiões base
- `GuardianMovementService` - IA de perseguição
- `EventService` - Eventos de ovos raros
- `InteractionService` - Roubo e entrega
- `PlayerInitService` - Setup de jogadores
- `HatchService` - Eclosão de ovos
- `RemoteEventService` - Rede cliente-servidor

### Controllers do Cliente

- `UIController` - Interface HUD
- `FXController` - Efeitos visuais
- `AnimationController` - Animações
- `PromptController` - Notificações
- `BaseMarkerController` - Marcadores
- `RemoteEventConnections` - Handlers de rede
- `InteractionPrompts` - Sistema de NPCs

## 🎮 Mecânicas Principais

### Loop de Gameplay

```
PEGAR OVO → INCUBAR → PROTEGER → ROUBAR OUTROS → FUGIR
    ↑                                              ↓
    ←←← ENTREGAR → CHOCAR → GANHAR PET → RENDA ←←←
```

### Raridades de Ovos

| Raridade | Probabilidade | Valor | Renda/s | Incubação |
|----------|---|---|---|---|
| COMUM | 55% | 100 💰 | 2/s | 30s |
| INCOMUM | 25% | 250 💰 | 4/s | 45s |
| RARO | 12% | 500 💰 | 6/s | 60s |
| ÉPICO | 5% | 1000 💰 | 10/s | 90s |
| LENDÁRIO | 2.5% | 2500 💰 | 15/s | 120s |
| MÍTICO | 0.5% | 5000 💰 | 25/s | 180s |

### 6 Guardiões Únicos

Cada área selvagem tem seu guardião protetor:

1. **Prado** (Fácil) → Galinha Brava 🐔
2. **Lago** (Fácil) → Sapo 🐸
3. **Deserto** (Médio) → Escorpião 🦂
4. **Geleira** (Médio) → Golem de Gelo ❄️
5. **Vulcão** (Difícil) → Lagarto Magma 🔥
6. **Celestial** (Difícil) → Criatura Astral ✨

## 🗺️ Estrutura do Mapa

### Layout em T

```
┌─────────────────────────────┐
│  BASES 1-6 (lado a lado)   │
│  └─ Identif. visual clara   │
└────────────┬────────────────┘
             │ CORREDOR 1
      ┌──────┴──────┐
      │  ÁREA 1     │
      │ Prado|Lago  │
      └──────┬──────┘
             │ CORREDOR 2
      ┌──────┴──────┐
      │  ÁREA 2     │
      │Deser|Gelo   │
      └──────┬──────┘
             │ CORREDOR 3
      ┌──────┴──────┐
      │  ÁREA 3     │
      │Vulc|Celes   │
      └─────────────┘

ACIMA DAS BASES:
- SHOP (Dona Casca)
- EVENT PEDESTAL (Eventos raros)
- SPEED TRAINING (Teo Turbo)
```

## ⚙️ Sistemas Principais

### Sistema de Roubo

1. Ladrão seleciona ovo inimigo
2. Servidor valida: distância, estado, propriedade
3. Se válido: ovo muda estado para CARRIED
4. Ladrão fica 35% mais lento
5. Dono recebe notificação
6. Ladrão pode recuperar ou entregar

**Recuperação:**
- Dono pode pegar o ovo caído
- Ovo retorna após 30s sem ação

**Entrega:**
- Ladrão leva até sua base
- Entra na DeliveryZone
- Propriedade muda para ladrão
- Ovo começa incubação nova

### Sistema de Guardiões

**Perseguição:**
- Guardião agride quando ovo é roubado
- Perseguição agressiva e constante
- Não desiste por distância
- Respeita limites de área
- Movimento acompanha terreno

**Escape:**
- Cruzar EscapeZone para corredor
- Guardião para na entrada
- Feedback "ESCAPOU!"
- Guardião retorna ao ninho suavemente

### Sistema de Speed

**Progressão:**
- Começa em Speed 0
- 100 XP = 1 level
- Max level = 12
- Cada nível +1.5 velocidade

**Treinamento:**
- NPC "Teo Turbo" na academia
- XP ganha ao se mover na esteira
- Level up mostra notificação

**Desbloqueios de Áreas:**
- Speed 0 → Prado
- Speed 2 → Lago
- Speed 4 → Deserto
- Speed 6 → Geleira
- Speed 8 → Vulcão
- Speed 11 → Celestial

### Sistema de Upgrades

#### 🔥 Incubadora (4 níveis)
- Reduz tempo de incubação
- Nível 1 (1000💰): 85% tempo
- Nível 2 (2500💰): 70% tempo
- Nível 3 (5000💰): 55% tempo
- Nível 4 (10000💰): 40% tempo

#### 🛡️ Barreira (3 níveis)
- Repele invasores na entrada
- Nível 1 (1500💰): PushForce 50
- Nível 2 (3500💰): PushForce 75
- Nível 3 (7500💰): PushForce 100

#### 🔔 Alarme (2 níveis)
- Alerta quando base invadida
- Nível 1 (800💰): Notificação
- Nível 2 (2000💰): Som + Luz

#### ⚡ Ninho Elétrico (4 níveis)
- Choca ladrão que rouba
- Reduz velocidade temporariamente
- Nível 1 (1200💰): -20% por 3s
- Nível 2 (2800💰): -35% por 4s
- Nível 3 (5500💰): -50% por 5s
- Nível 4 (10000💰): -70% por 6s

### Sistema de Eventos

**Spawning:**
- Evento a cada 45 segundos
- Dura 60 segundos
- Raridade aleatória (ÉPICO, LENDÁRIO, MÍTICO)

**Reclamação:**
- Qualquer jogador pode reclamar
- Primeiro a chegar ganha
- Propriedade transferida imediatamente
- Próximo evento começa

## 💾 Sistema de Dados

### Estrutura do Jogador

```lua
{
    Coins = 500,                -- Moeda atual
    Pets = {},                  -- IDs das criaturas
    SpeedLevel = 0,             -- Nível 0-12
    SpeedXP = 0,                -- XP para próximo
    IncubatorLevel = 0,         -- Upgrade
    BarrierLevel = 0,           -- Upgrade
    AlarmLevel = 0,             -- Upgrade
    ShockLevel = 0,             -- Upgrade
    StarterClaimed = false,     -- Ovo inicial
    LastSave = tick()           -- Timestamp
}
```

### Estados de Ovo

- `Created` - Recém gerado
- `Wild` - Na natureza
- `Event` - Evento raro ativo
- `Incubating` - Incubando na base
- `Carried` - Sendo carregado
- `Dropped` - Caiu no chão
- `Hatching` - Processo de eclosão

## 🔒 Anti-Exploit

- ✅ Servidor valida toda ação crítica
- ✅ Distância de interação verificada
- ✅ Propriedade de ovo validada
- ✅ Coins checados antes de compra
- ✅ Estado do ovo validado
- ✅ Nenhum dado crítico no cliente

## 📈 Performance

- ✅ Compatível com PC fraco e mobile
- ✅ FPS 60+ em PC, 30+ em mobile
- ✅ Sem loops GetDescendants por frame
- ✅ VFX com limite de 3 simultâneos
- ✅ Cache de dados do jogador
- ✅ Auto-save a cada 30s
- ✅ UI responsiva

## 🔧 Como Sincronizar com Rojo

```bash
# 1. Instalar Rojo
wget https://github.com/rojo-rbx/rojo/releases

# 2. No diretório do projeto
rojo serve

# 3. Em Roblox Studio
# Rojo Plugin → Connect → http://localhost:34872

# 4. Sincronizar arquivo
# Clique no arquivo no Explorer → Sync into game
```

## ✅ Status do Projeto

**v0.1.0 - Beta Launch**

### Implementado
- ✅ Estrutura Rojo 100% completa
- ✅ 6 bases jogáveis lado a lado
- ✅ 3 áreas com 6 guardiões únicos
- ✅ Sistema de roubo com validação
- ✅ Perseguição e EscapeZones
- ✅ Incubação e hatching de ovos
- ✅ Geração de renda por pets
- ✅ 4 tipos de upgrades funcionais
- ✅ Sistema de Speed completo
- ✅ Shop operacional (5 itens)
- ✅ Eventos raros (ÉPICO/LENDÁRIO/MÍTICO)
- ✅ DataStore integrado
- ✅ UI HUD completa
- ✅ Sistema de notificações
- ✅ VFX (roubo, hatch, etc)
- ✅ Suporte mobile
- ✅ Anti-exploit básico
- ✅ 17 serviços + 7 controllers

### Documentação
- ✅ README completo
- ✅ CHANGELOG detalhado
- ✅ QA Checklist extenso
- ✅ Código comentado

## 🚀 Próximas Melhorias

- [ ] Animações de personagem customizadas
- [ ] Mais efeitos de partículas especiais
- [ ] Leaderboard de roubo
- [ ] Chat integrado
- [ ] Badges e achievements
- [ ] Trading entre jogadores
- [ ] Guildas/Times cooperativos
- [ ] Seasonal events
- [ ] Boss raids cooperativas
- [ ] Skins customizáveis

## 📞 Suporte

Abra uma **issue** no GitHub para:
- 🐛 Reportar bugs
- 💡 Sugerir features
- 📚 Perguntas sobre o código
- 🎨 Ideias de design

---

**Desenvolvido com ❤️ usando Rojo + Luau**

**Data de Lançamento:** 31/08/2026
**Versão:** 0.1.0 (Beta)
**Status:** ✨ Em Desenvolvimento Ativo
