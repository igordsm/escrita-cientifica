
function Para(par) 
  if #par.content == 1 then
    local el = par.content[1]

    if el.t == 'Str' and el.text == "[spacer]" then
      -- return pandoc.RawInline('html', '<div class="spacer-medium"></div>')
      return pandoc.RawInline('latex', '\\vspace{15em}')
    end
    if el.t == 'Str' and el.text == "[line-spacer]" then
      -- return pandoc.RawInline('html', '<div class="spacer-medium"></div>')
      return pandoc.RawInline('latex', '\\vspace{3em}')
    end
    if el.t == 'Str' and el.text == "[big-spacer]" then
      -- return pandoc.RawInline('html', '<div class="spacer-medium"></div>')
      return pandoc.RawInline('latex', '\\vspace{25em}')
    end
    
    if el.t == 'Str' and el.text == "[break]" then
      -- return pandoc.RawInline('html', '<div class="page-break"></div>')
      return pandoc.RawInline('latex', '\\pagebreak')
    end  end
  return par
end
