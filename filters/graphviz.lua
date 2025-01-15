-- inspired by https://github.com/pandoc/lua-filters/blob/5686d96/diagram-generator/diagram-generator.lua

local dotPath = os.getenv("DOT") or "dot"

local filetype = "pdf"
local mimetype = "image/svg+xml"

local function graphviz(code, filetype, outname)
    return pandoc.pipe(dotPath, {"-T" .. filetype, "-o" .. outname}, code)
end

function CodeBlock(block)
    local converters = {
        graphviz = graphviz,
    }

    local img_converter = converters[block.classes[1]]
    if not img_converter then
      return block
    end

    local fname = 'temp/' .. pandoc.utils.sha1(block.text) .. '.pdf'
    local code = block.text
    code = string.gsub(code, "^(d?i?)graph%s+(%w+)%s+{", "%1graph %2 { graph[margin=0.1]\n")
    code = string.gsub(code, "subgraph%s(%w+%d)%s?{", "subgraph %1 { margin=10\n")
    
    local success, img = pcall(img_converter, code, filetype, fname)

    if not success then
        io.stderr:write(tostring(img))
        io.stderr:write('\n')
        error 'Image conversion failed. Aborting.'
    end
    return {
      pandoc.RawInline('latex', '\\centerline{'),
      pandoc.Image({}, fname, '', block.attr),
      pandoc.RawInline('latex', '}')

    } 
end

return {
    {CodeBlock = CodeBlock},
}
