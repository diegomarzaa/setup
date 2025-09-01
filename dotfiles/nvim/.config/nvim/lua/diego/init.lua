-- Set leader before anything else
vim.g.mapleader = " "

-- Bootstrap plugin manager + then load the rest
require("diego.lazy_init")
require("diego.remap")
require("diego.set")