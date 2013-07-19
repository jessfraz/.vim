" TODO: create cssFlexboxProp group and cssFlexboxAttr group
syn keyword cssFontProp order
syn match cssFontProp contained "\<flex\(-\(basis\|direction\|flow\|grow\|shrink\|wrap\)\)\=\>"
syn keyword cssFontAttr contained flex row wrap
syn match cssFontAttr contained "\<inline-flex\>"
syn match cssFontAttr contained "\<\(row\|column\|wrap\)-reverse\>"
