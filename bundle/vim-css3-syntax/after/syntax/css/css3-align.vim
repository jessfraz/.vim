" TODO: create cssAlignProp group and cssAlignAttr group
syn match cssFontProp contained "\<\(justify\|align\)-\(self\|content\|items\)\>"
syn keyword cssFontAttr contained safe true
syn match cssFontAttr contained "\<\(self\|flex\)-\(start\|end\)\>"
syn match cssFontAttr contained "\<space-\(between\|around\|evenly\)\>"
