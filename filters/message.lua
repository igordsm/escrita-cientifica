function Div(d) 
  if #d.classes ~= 1 then
    return nil
  end

  -- if #d.content > 1 then
  --   local message_title = d.content[1]
  --   local message_header = pandoc.Div (message_title, {class="message-header"})
    
  --   table.remove(d.content, 1)
  --   local message_body = pandoc.Div (d.content, {class="message-body"})

  --   return pandoc.Div ({message_header, message_body}, {class="message " .. message_type })
  -- end

  local title = ' '
  if #d.content > 1 then
    title = pandoc.write(pandoc.Pandoc({d.content[1]}), 'latex')
    table.remove(d.content, 1)
  end
  local colors = {
    tip = "Blue",
    info = "Blue",
    done = "Green",
    warn = "Yellow"
  }
  
  local c = colors[d.classes[1]]

  return {
    pandoc.RawBlock('latex', '\\begin{box' .. c .. '}{' .. title .. '}'),
    d,
    pandoc.RawBlock('latex', '\\end{box' .. c .. '}')
  }
end
