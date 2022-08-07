--- Commands
require('Utils')

local cmd = Utils.cmd_alias

cmd('NT', ':NvimTreeToggle')
cmd('NTR', ':NvimTreeRefresh')
cmd('NTF', ':NvimTreeFindFile')

cmd('F', ':Telescope find_files')
cmd('B', ':Telescope buffers');

cmd('BD', ':')
cmd('C', ':close')

