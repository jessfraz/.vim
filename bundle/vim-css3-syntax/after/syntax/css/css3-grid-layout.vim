" TODO: create cssGridLayoutProp group and cssGridLayoutAttr group
syn match cssFontProp contained "\<grid-\(definition-\(rows\|columns\)\|template\|auto-\(rows\|columns\)\|before\|start\|after\|end\|column\|row\|area\|auto-flow\)\>"
syn keyword cssFontAttr contained grid subgrid rows
syn match cssFontAttr contained "\<inline-grid\>"
