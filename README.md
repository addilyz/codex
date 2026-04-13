# codex
Simple alternative LÖVE event handler using per-callback tables of functions with the `next` operator.
## Functions

`codex.add(key,table)` is used to add a table of love callback functions to their respective codex tables under the given key.

`codex.delete(key)` deletes every function with the given key in each codex event table.

`codex.pages.getPage(number)` is used to get a graphics layer table to add draw functions to.

`codex.pages.expunge(key)` deletes every function with the given key in all pages layers.

`codex.pages.crumple(number)` removes all functions from a layer by replacing it with an empty table.

# pages
Draw function layering system for codex. Check the code snippets below for more context.
# Tips & Recommended Use
```
-- you can add to codex directly with a function declaration
require "codex/codex"
function codex.update.example(dt) end

-- or assignment of a function
function mykeycode(k) print(k) end
codex.keypressed.exampletwo = mykeycode

-- or you can batch add functions from a properly formatted table
exampleThree = {}
function exampleThree.load() end
function exampleThree.update(dt) end
function exampleThree.keypressed(k) end
codex.add("exampleLibrary",exampleThree)

--- however, you cannot add draw functions. pages implements these.

----- pages!
-- pages is a sublibrary that is required by codex but does not require codex.
-- you will likely access these functions through codex.pages instead of pages.

-- unless you add this line, i guess.
local pages = codex.pages

--- or require it on its own if you just want easy layers.
--pages = require "codex/pages"

-- get a page or two.
local pageone = pages.getPage(1)
local pagetwo = pages.getPage(2)

-- we can add to the pages with our first two codex assignment techniques
-- of direct function declaration
function pagetwo.example()
  love.graphics.setColor(0,0,0,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth()/2,love.graphics.getHeight())
end

-- and assigning the draw function.
function drawFunc()
  love.graphics.setColor(1,1,1,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
end
pageone.example = drawFunc

--- deletion in codex/pages
function deletePageExamples()
-- delete from all pages by key
  pages.expunge("example")
-- or wipe a specific page by number
  pages.crumple(2)
end
