-- Automatically change statusline color based on git repository
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    priority = 1000,
    config = function(_, opts)
      -- Repository-to-color mapping
      local repo_colors = {
        ["devops"] = {
          bg = "#cc241d", -- Red for devops (production/critical)
          fg = "#fbf1c7",
        },
        ["backend"] = {
          bg = "#458588", -- Blue for backend
          fg = "#fbf1c7",
        },
        ["frontend"] = {
          bg = "#98971a", -- Green for frontend
          fg = "#fbf1c7",
        },
        ["fc-data-service"] = {
          bg = "#d79921", -- Yellow/Orange for data-services
          fg = "#282828",
        },
        ["fc-odoo-service"] = {
          bg = "#b16286", -- Purple for odoo
          fg = "#fbf1c7",
        },
        ["mobile"] = {
          bg = "#689d6a", -- Teal for mobile
          fg = "#fbf1c7",
        },
        -- Add more repositories here
        -- ["repo-name"] = { bg = "#hexcolor", fg = "#hexcolor" },
      }

      -- Function to get current git repository name
      local function get_repo_name()
        -- Try using git command first (most reliable)
        local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          if result and result ~= "" then
            -- Extract just the directory name from the full path
            local repo_path = result:gsub("\n", "")
            return vim.fn.fnamemodify(repo_path, ":t")
          end
        end

        -- Fallback: search for .git directory
        local git_dir = vim.fn.finddir(".git", ".;")
        if git_dir ~= "" then
          local repo_path = vim.fn.fnamemodify(git_dir, ":h")
          return vim.fn.fnamemodify(repo_path, ":t")
        end

        return nil
      end

      -- Function to create custom theme based on repository
      local function get_custom_theme()
        local repo_name = get_repo_name()

        -- Default theme (gruvbox-based)
        local default_colors = {
          bg = "#3c3836",
          fg = "#ebdbb2",
        }

        -- Get colors for current repo or use default
        local colors = repo_colors[repo_name] or default_colors

        -- Create a custom theme
        local custom_theme = {
          normal = {
            a = { bg = colors.bg, fg = colors.fg, gui = "bold" },
            b = { bg = "#504945", fg = "#ebdbb2" },
            c = { bg = "#3c3836", fg = "#a89984" },
          },
          insert = {
            a = { bg = colors.bg, fg = colors.fg, gui = "bold" },
            b = { bg = "#504945", fg = "#ebdbb2" },
          },
          visual = {
            a = { bg = colors.bg, fg = colors.fg, gui = "bold" },
            b = { bg = "#504945", fg = "#ebdbb2" },
          },
          replace = {
            a = { bg = colors.bg, fg = colors.fg, gui = "bold" },
            b = { bg = "#504945", fg = "#ebdbb2" },
          },
          command = {
            a = { bg = colors.bg, fg = colors.fg, gui = "bold" },
            b = { bg = "#504945", fg = "#ebdbb2" },
          },
          inactive = {
            a = { bg = "#3c3836", fg = "#a89984" },
            b = { bg = "#3c3836", fg = "#a89984" },
            c = { bg = "#3c3836", fg = "#a89984" },
          },
        }

        return custom_theme
      end

      -- Add repository name to statusline
      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}

      table.insert(opts.sections.lualine_x, 1, {
        function()
          local repo_name = get_repo_name()
          return repo_name and ("  " .. repo_name) or ""
        end,
        color = function()
          local repo_name = get_repo_name()
          local colors = repo_colors[repo_name]
          if colors then
            return { bg = colors.bg, fg = colors.fg, gui = "bold" }
          end
          return nil
        end,
      })

      -- Function to update lualine theme
      local function update_lualine_theme()
        opts.options = opts.options or {}
        opts.options.theme = get_custom_theme()
        require("lualine").setup(opts)
      end

      -- Initial setup
      update_lualine_theme()

      -- Auto-update theme when changing directories or entering buffers
      vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter", "VimEnter" }, {
        callback = function()
          vim.schedule(function()
            update_lualine_theme()
          end)
        end,
      })
    end,
  },
}
