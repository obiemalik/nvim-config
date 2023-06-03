--- Commands
local cmd = require('utils').cmd_alias

cmd('NT', ':NvimTreeToggle')
cmd('NTR', ':NvimTreeRefresh')
cmd('NTF', ':NvimTreeFindFile')

cmd('F', ':Telescope find_files')
cmd('B', ':Telescope buffers');

cmd('DVO', ':DiffviewOpen', { nargs = 1})
cmd('DVC', ':DiffviewClose')
cmd('DVR', ':DiffviewRefresh')
cmd('DVF', ':DiffviewFileHistory')

cmd('VR', 'vertical resize <args>', { nargs = 1 })

cmd('CopyFilePath', ':let @+=@%')
cmd('W', ':w!')
cmd('BD', 'bprev | bdelete #')
cmd('C', 'close')
cmd('Q', 'quit')
cmd('QQ', 'quitall')
