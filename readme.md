glslVim
=======

This is a plugin for Vim providing extensive support for editing OpenGL Shading
Language (GLSL) code. For complete documentation, install the plugin. Then, in
Vim, type `:help glsl`.

If you find a bug, or would like to request a feature, open an
[issue](https://github.com/brobeson/glslVim/issues).

---

## Installation
1. Download the vimball file.
1. Open the vimball in Vim.
1. Type `:so %`, then exit Vim.
1. If it doesn't exist, create the file `filetype.vim` in your Vim runtime path.
   This is typically `~/.vim/` on Linux and `C:\Users\you\vimfiles\` on
   Windows.
1. Open the `filetype.vim` file. Add the following lines:

```
augroup filetypedetect
   au BufNewFile,BufRead *.glsl setf glsl
augroup END
```

## Provided Capabilities
Here is a summary of the functionality included in the plugin.

#### Syntax Highlighting
Basic syntax highlighting is provided. Most of it is analogous to C and C++
highlighting.

