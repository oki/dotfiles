if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

" moje snipety
exec "Snippet rb #!/usr/bin/env ruby<CR><CR>".st.et
exec "Snippet def def ".st."methodName".et."<CR><Tab>".st.et."<CR>end<CR>"
exec "Snippet deft def test_".st."methodName".et."<CR><Tab>".st.et."<CR>end<CR>"
exec "Snippet defi def initialize".st.et."<CR><Tab>".st.et."<CR>end<CR>"
exec "Snippet lf if $0 == __FILE__<CR><Tab>".st.et."<CR>end<CR>".st.et



" testy
exec "Snippet rtt require 'test/unit'<CR>class Test".st."className".et." < Test::Unit::TestCase<CR><Tab><CR><Tab>def test_".st."methodName".et."<Tab><CR><Tab><Tab>".st.et."<CR><Tab>end<CR>end"
exec "Snippet ae assert_equal ".st."got".et.", ".st."expected".et.""

" ...
exec "Snippet do do<CR><Tab>".st.et."<CR>end<CR>".st.et
exec "Snippet class class ".st."className".et."<CR><Tab>".st.et."<CR>end<CR>".st.et
exec "Snippet begin begin<CR><Tab>".st.et."<CR>rescue ".st."Exception".et." => ".st."e".et."<CR>".st.et."end<CR>".st.et
exec "Snippet each_with_index0 each_with_index do |".st."element".et.", ".st."index".et."|<CR><Tab>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet collect collect { |".st."element".et."| ".st."element".et.".".st.et." }<CR><Tab>".st.et
exec "Snippet forin for ".st."element".et." in ".st."collection".et."<CR><Tab>>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet doo do |".st."object".et."|<CR>".st.et."<CR>end<CR>".st.et
exec "Snippet : :".st."key".et." => \"".st."value".et."\"".st.et."<CR>".st.et
exec "Snippet case case ".st."object".et."<CR><Tab>when ".st."condition".et."<CR>".st.et."<CR>end<CR>".st.et
exec "Snippet collecto collect do |".st."element".et."|<CR><Tab>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet each each { |".st."element".et."| ".st."element".et.".".st.et." }<CR>".st.et
exec "Snippet each_with_index each_with_index { |".st."element".et.", ".st."idx".et."| ".st."element".et.".".st.et." }<CR>".st.et
exec "Snippet if if ".st."condition".et."<CR><Tab>".st.et."<CR>end<CR>".st.et
exec "Snippet eacho each do |".st."element".et."|<CR><Tab>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet unless unless ".st."condition".et."<CR><Tab>".st.et."<CR>end<CR>".st.et
exec "Snippet ife if ".st."condition".et."<CR><Tab>".st.et."<CR>else<CR><Tab>".st.et."<CR>end<CR>".st.et
exec "Snippet when when ".st."condition".et."<CR>".st.et
exec "Snippet selecto select do |".st."element".et."|<CR><Tab>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet injecto inject(".st."object".et.") do |".st."injection".et.", ".st."element".et."| <CR><Tab>".st.et."<CR>end<CR>".st.et
exec "Snippet reject { |".st."element".et."| ".st."element".et.".".st.et." }<CR>".st.et
exec "Snippet rejecto reject do |".st."element".et."| <CR><Tab>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet inject inject(".st."object".et.") { |".st."injection".et.", ".st."element".et."| ".st.et." }<CR>".st.et
exec "Snippet select select { |".st."element".et."| ".st."element".et.".".st.et." }<CR>".st.et
