" TODO: create cssGridLayoutProp group and cssGridLayoutAttr group
syn match cssFontProp contained "\<grid-template\(-\(columns\|rows\|areas\)\)\=\>"
syn match cssFontProp contained "\<grid-auto-\(columns\|rows\|flow\|position\)\>"
syn match cssFontProp contained "\<grid-\(row\|column\)\(-\(start\|end\)\)\=\>"
syn match cssFontProp contained "\<grid-area\>"
syn keyword cssFontAttr contained grid subgrid rows columns dense span
syn match cssFontAttr contained "\<inline-grid\>"
syn match cssValueNumber contained "[01]\(.\d\+\)\=fr"
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(minmax\|repeat\)\s*(" end=")" oneline keepend
