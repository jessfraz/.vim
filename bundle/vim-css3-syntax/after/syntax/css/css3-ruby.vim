" TODO: create cssRubyProp group and cssRubyAttr group
syn match cssFontProp contained "\<ruby-\(align\|overhang\|position\|span\)"
syn keyword cssFontAttr contained start end
syn match cssFontAttr contained "\<distribute-\(letter\|space\)\>"
syn match cssFontAttr contained "\<line-edge\>"
