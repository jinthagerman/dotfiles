-- Rex config: ~/.config/rex/init.lua -> ~/.yadr/rex/init.lua
-- Docs: https://www.superlogical.com/rex/docs/customize/config
-- After editing: `rex config check && rex config reload`

local TERMINAL = "com.superlogical.terminal"
local SHELL = "com.superlogical.terminal.shell"

-- Working directory of a terminal block: its foreground process's cwd (works
-- even while an agent is running), falling back to what the shell reported.
local function block_cwd(block_id)
  local p = rex.block.call(TERMINAL, "process", { block_id = block_id })
  if p then
    if p.foreground and p.foreground.cwd then return p.foreground.cwd end
    if p.ancestors and p.ancestors[1] and p.ancestors[1].cwd then return p.ancestors[1].cwd end
  end
  local w = rex.block.call(TERMINAL, "pwd", { block_id = block_id })
  return w and (w.pwd or w.path) or nil
end

local function terminal(opts)
  return rex.layout.block{ flavor = SHELL, options = opts }
end

-- 1. Claude here ---------------------------------------------------------------
rex.action{
  name = "claude_here",
  title = "Claude Here",
  category = "Agents",
  description = "Split right and start Claude Code in the focused pane's directory.",
  keywords = "agent claude split",
  run = function(ctx)
    return rex.session.new_split{
      session_id = ctx.session_id,
      anchor_id = ctx.block_id,
      direction = "horizontal",
      side = "after",
      focus = true,
      layout = terminal{ command = { "claude" }, cwd = block_cwd(ctx.block_id) },
    }
  end,
}

-- 2. New agent worktree ----------------------------------------------------------
-- New tab in the same repo with `wt ` typed: add a branch name, Enter, then start an agent.
rex.action{
  name = "agent_worktree",
  title = "New Agent Worktree Tab",
  category = "Agents",
  description = "Open a tab in the focused pane's directory with `wt ` ready to type a branch.",
  keywords = "agent git worktree branch tab",
  run = function(ctx)
    return rex.session.new_window{
      session_id = ctx.session_id,
      focus = true,
      layout = terminal{ cwd = block_cwd(ctx.block_id), initial_input = "wt " },
    }
  end,
}

-- 3. Jump to waiting agent ---------------------------------------------------------
-- Cycles through terminals whose program reported `blocked` (needs you), then
-- `done` (finished, unseen), across every session.
local PRIORITY = { blocked = 1, done = 2 }

local function waiting_blocks()
  local found = {}
  local sessions = rex.call("session.list")
  for _, s in ipairs(sessions and sessions.sessions or {}) do
    local list = rex.session.list_blocks{ session_id = s.session_id }
    for _, b in ipairs(list and list.blocks or {}) do
      if b.creator_name == TERMINAL and b.placement == "placed" then
        local st = rex.block.call(TERMINAL, "program_status", { block_id = b.block_id })
        local best
        for _, r in ipairs(st and st.records or {}) do
          local p = PRIORITY[r.state]
          if p and (not best or p < best) then best = p end
        end
        if best then
          found[#found + 1] = {
            priority = best, order = #found,
            session_id = s.session_id, window_id = b.window_id, block_id = b.block_id,
          }
        end
      end
    end
  end
  table.sort(found, function(a, b)
    if a.priority ~= b.priority then return a.priority < b.priority end
    return a.order < b.order
  end)
  return found
end

rex.action{
  name = "jump_waiting_agent",
  title = "Jump to Waiting Agent",
  category = "Agents",
  description = "Focus the next terminal whose agent is blocked on you, then ones that finished.",
  keywords = "agent blocked waiting done next attention",
  run = function(ctx)
    local list = waiting_blocks()
    if #list == 0 then return { message = "No agents waiting" } end
    -- Start after the focused block so repeated presses cycle.
    local target = list[1]
    for i, b in ipairs(list) do
      if b.block_id == ctx.block_id then target = list[i % #list + 1] break end
    end
    rex.session.focus_block{ session_id = target.session_id, block_id = target.block_id }
    if target.session_id ~= ctx.session_id then
      rex.client.queue("session.select", { session_id = target.session_id, window_id = target.window_id })
    end
    return target
  end,
}

-- 4. Review changes -------------------------------------------------------------------
rex.action{
  name = "review_changes",
  title = "Review Changes",
  category = "Agents",
  description = "Split below with Neovim showing the repo's changed files.",
  keywords = "agent review diff git changes nvim",
  run = function(ctx)
    return rex.session.new_split{
      session_id = ctx.session_id,
      anchor_id = ctx.block_id,
      direction = "vertical",
      side = "after",
      focus = true,
      layout = terminal{
        command = { "nvim", "-c", "lua Snacks.picker.git_status()" },
        cwd = block_cwd(ctx.block_id),
      },
    }
  end,
}

-- 5. Scratch shell --------------------------------------------------------------------
rex.action{
  name = "scratch_shell",
  title = "Scratch Shell",
  category = "Agents",
  description = "Floating shell in the focused pane's directory.",
  keywords = "scratch float shell quick",
  run = function(ctx)
    return rex.session.new_layer{
      session_id = ctx.session_id,
      bounds = { 0.1, 0.1, 0.8, 0.8 },
      focus = true,
      layout = terminal{ cwd = block_cwd(ctx.block_id) },
    }
  end,
}

-- Keys (avoiding Rex defaults: shift+cmd+w closes window, shift+cmd+s toggles tab style)
rex.bind("shift+cmd+c", "claude_here")
rex.bind("shift+cmd+t", "agent_worktree")
rex.bind("shift+cmd+j", "jump_waiting_agent")
rex.bind("shift+cmd+r", "review_changes")
rex.bind("shift+cmd+f", "scratch_shell")
