" TODO: create cssRegionsProp group and cssRegionsAttr group
syn match cssFontProp contained "\<flow-\(from\|into\)\>"
syn match cssFontProp contained "\<region-fragment\>"
syn keyword cssFontAttr contained element content break
syn match cssFontAttr contained "\<\(avoid-\)\=region\>"
syn region cssPseudoClassLang matchgroup=cssPseudoClassId start="::\=region(" end=")" oneline
