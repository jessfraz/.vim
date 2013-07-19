" TODO: create cssShapesProp group
syn match cssFontProp contained "\<shape-\(image-threshold\|inside\|outside\)\>"
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(\(inset-\)\=rectangle\|circle\|ellipse\|polygon\)\s*(" end=")" oneline keepend
