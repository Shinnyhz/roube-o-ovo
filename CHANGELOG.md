# Changelog - ROUBE O OVO

## v0.1.0 - Launch Beta (31/08/2026)

### 🎉 Adicionado
- ✨ Estrutura Rojo completa e funcional
- ✨ 6 bases jogáveis lado a lado com identidade visual
- ✨ 3 áreas selvagens com 6 guardiões únicos
- ✨ Sistema de raridade de ovos (6 tipos: COMUM até MÍTICO)
- ✨ Mecânica de roubo com validação completa
- ✨ Sistema de guardiões com perseguição inteligente
- ✨ EscapeZones para fugir de guardiões
- ✨ Incubação e hatching de ovos com progresso visual
- ✨ Geração de renda passiva por pets
- ✨ 4 tipos de upgrades (Incubadora, Barreira, Alarme, Choque)
- ✨ Sistema de Speed com treinamento (0-12 níveis)
- ✨ Shop com NPC (Dona Casca) e 5 itens
- ✨ Eventos com ovos raros a cada 45s
- ✨ DataStore para persistência de dados
- ✨ UI HUD compacto e responsivo
- ✨ Sistema de notificações com cores
- ✨ VFX de roubo, hatch e efeitos especiais
- ✨ Suporte completo a mobile
- ✨ Anti-exploit básico implementado

### 🛠️ Sistemas Implementados
- ✅ MapService - Construção do mapa em T
- ✅ BaseService - Gerenciamento de 6 bases
- ✅ EggService - Ciclo de vida completo dos ovos
- ✅ GuardianService - Guardiões estáticos base
- ✅ GuardianMovementService - IA com perseguição inteligente
- ✅ CreatureService - Criação e gerenciamento de pets
- ✅ EconomyService - Sistema de renda/s
- ✅ SpeedService - Progressão de velocidade com XP
- ✅ UpgradeService - Sistema de 4 upgrades
- ✅ ShopService - Compras e transações
- ✅ DataService - Persistência com DataStore
- ✅ EventService - Eventos raros com timer
- ✅ InteractionService - Roubo, entrega, recuperação
- ✅ PlayerInitService - Setup automático de novos jogadores
- ✅ HatchService - Eclosão de ovos com timer
- ✅ RemoteEventService - 7 RemoteEvents de rede
- ✅ DiagnosticsService - Validação de mapa

### 🎮 Controllers do Cliente
- ✅ UIController - HUD com coins, pets, income, speed, xp
- ✅ FXController - Efeitos visuais (números flutuantes, hatch, roubo)
- ✅ AnimationController - Animações de personagem
- ✅ PromptController - Notificações e prompts interativos
- ✅ BaseMarkerController - Marcadores visuais de bases
- ✅ RemoteEventConnections - 7 handlers de eventos remotos
- ✅ InteractionPrompts - Sistema de interação com NPCs

### 📊 Estrutura de Dados
- ✅ GameConfig - Configurações globais centralizadas
- ✅ EggConfig - 6 raridades com stats únicos
- ✅ CreatureConfig - Definições de pets por raridade
- ✅ AreaConfig - Mapa com 3 áreas e 6 spots
- ✅ UpgradeConfig - 4 upgrades com 4 níveis cada
- ✅ ShopConfig - 5 itens da loja
- ✅ SoundConfig - Referência para efeitos sonoros

### 📈 Métricas de Raridade
| Raridade | Prob. | Valor | Renda/s | Tempo |
|----------|-------|-------|---------|-------|
| COMUM | 55% | 100 | 2 | 30s |
| INCOMUM | 25% | 250 | 4 | 45s |
| RARO | 12% | 500 | 6 | 60s |
| ÉPICO | 5% | 1000 | 10 | 90s |
| LENDÁRIO | 2.5% | 2500 | 15 | 120s |
| MÍTICO | 0.5% | 5000 | 25 | 180s |

### 🐛 Bugs Conhecidos
- Ocasionalmente guardiões podem ficar presos em terreno irregular (raro)
- UI não é 100% responsiva em telas < 320px (muito pequenas)
- Efeitos de som podem não funcionar em alguns navegadores/dispositivos

### 📋 Validação Completa
- ✅ Servidor valida toda ação crítica
- ✅ Distância de interação verificada (raycast)
- ✅ Propriedade de ovo sempre validada
- ✅ Coins checados antes de qualquer compra
- ✅ Estado do ovo validado antes de qualquer transação
- ✅ Nenhum dado crítico armazenado no cliente
- ✅ Exploits de velocidade mitigados
- ✅ Duplicação de ovos prevenida

---

## Roadmap Futuro

### v0.2.0 - Polimento Visual
- [ ] Animações customizadas de guardiões
- [ ] Mais variações de VFX especiais
- [ ] Modelos 3D para guardiões (substituir partes)
- [ ] Skins customizáveis para pets
- [ ] Efeitos de partículas melhorados

### v0.3.0 - Interação Social
- [ ] Leaderboard de roubo/entrega
- [ ] Chat integrado no jogo
- [ ] Badges e achievements
- [ ] Reputação por ação

### v0.4.0 - Economia Avançada
- [ ] Trading entre jogadores
- [ ] Mercado de itens
- [ ] Leilões de ovos raros
- [ ] Moedas premium

### v0.5.0 - Cooperação
- [ ] Guildas/Teams de jogadores
- [ ] Base compartilhada
- [ ] Defesa cooperativa
- [ ] Eventos de guilda

### v1.0.0 - Expansão
- [ ] Boss raids semanais
- [ ] Seasonal events temáticos
- [ ] Novo sistema de pet evolutions
- [ ] Dungeons cooperativas

---

**Data de Release:** 31/08/2026
**Versão Atual:** 0.1.0 (Beta)
**Status:** ✨ Em Desenvolvimento Ativo
