if !hlexists('cssShapesProp')
  syn match cssFontProp contained "\<shape-\(outside\|image-threshold\|margin\)\>"
  syn match cssFontAttr contained "\<margin-box\>"
  syn region cssFunction contained matchgroup=cssFunctionName start="\<\(inset\|circle\|ellipse\|polygon\)\s*(" end=")" oneline keepend
endif
