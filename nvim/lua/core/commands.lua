--- Commands
require('Utils')

local cmd = Utils.cmd_alias

cmd('NT', ':NvimTreeToggle')
cmd('NTR', ':NvimTreeRefresh')
cmd('NTF', ':NvimTreeFindFile')

cmd('F', ':Telescope find_files')
cmd('B', ':Telescope buffers');

cmd('VR', 'vertical resize <args>', { nargs=1 })

cmd('W', ':w')
cmd('BD', 'bprev | bdelete #')
cmd('C', ':close')

