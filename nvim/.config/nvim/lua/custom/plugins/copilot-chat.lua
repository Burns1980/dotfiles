return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      -- { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      prompts = {
        Review = {
          prompt = 'Please review the following code and provide suggestions for improvement.',
        },
        Refactor = {
          prompt = 'Please refactor the following code to improve its clarity and readability.',
        },
        BetterNamings = {
          prompt = 'Please provide better names for the following variables and functions.',
        },
        SwaggerApiDocs = {
          prompt = 'Please provide documentation for the following API using Swagger.',
        },
        SwaggerJsDocs = { prompt = 'Please write JSDoc for the following API using Swagger.' },
        -- Text related prompt
        Summarize = { prompt = 'Please summarize the following text.' },
        Spelling = { prompt = 'Please correct any grammar and spelling errors in the following text.' },
        Wording = { prompt = 'Please improve the grammar and wording of the following text.' },
        Concise = { prompt = 'Please rewrite the following text to make it more concise.' },
      },
      mappings = {
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
      },
      -- See Configuration section for options
      agent = 'copilot',
      chat_autocomplete = {
        enabled = false, -- Enable or disable chat autocompletion
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      local select = require 'CopilotChat.select'
      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
          end
        end,
      })
    end,
    event = 'VeryLazy',
    keys = {
      -- Show prompts actions with telescope
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt {
            context = {
              'buffers',
            },
          }
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>af',
        function()
          require('CopilotChat').chat:focus()
        end,
        desc = 'CopilotChat - Focus Chat Buffer',
      },
      {
        '<leader>az',
        function()
          require('CopilotChat').stop()
        end,
        desc = 'CopilotChat - Stop Current Output',
      },
      -- Generate commit message based on the git diff
      {
        '<leader>am',
        '<cmd>CopilotChatCommit<cr>',
        desc = 'CopilotChat - Generate commit message for all changes',
      },
      {
        '<leader>as',
        function()
          local input = vim.fn.input 'Enter Name to Save Chat as: '
          if input ~= '' then
            vim.cmd('CopilotChatSave ' .. input)
          end
        end,
        desc = 'CopilotChat - Save Chat',
      },
      {
        '<leader>al',
        function()
          local input = vim.fn.input 'Enter Name of Saved Chat:'
          if input ~= '' then
            vim.cmd('CopilotChatLoad ' .. input)
          end
        end,
        desc = 'CopilotChat - Load Saved Chat',
      },
      -- Quick chat with Copilot
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            vim.cmd('CopilotChatBuffer ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Clear buffer and chat history
      { '<leader>ar', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Toggle Copilot Chat Vsplit
      { '<leader>at', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      { '<leader>ao', '<cmd>CopilotChatOpen<cr>', desc = 'CopilotChat - Open Copilot Chat' },
      -- Copilot Chat Models
      { '<leader>a?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
      -- Copilot Chat Agents
      { '<leader>aa', '<cmd>CopilotChatAgents<cr>', desc = 'CopilotChat - Select Agents' },
    },
  },
}
