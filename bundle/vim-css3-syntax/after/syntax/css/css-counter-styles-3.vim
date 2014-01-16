" TODO: create cssCounterStyleDescriptor for `@counter-style` descriptor
syn keyword cssGeneratedContentProp contained negative prefix suffix range pad fallback
syn match cssGeneratedContentProp contained "\<\(additive-\)\=symbols\>"
syn match cssGeneratedContentProp contained "\<speak-as\>"
syn match cssGeneratedContentAttr contained "\<disclosure-\(open\|closed\)\>"
syn match cssGeneratedContentAttr contained "\<simp-chinese-\(in\)\=formal\>"
syn match cssGeneratedContentAttr contained "\<trad-chinese-\(in\)\=formal\>"
syn match cssGeneratedContentAttr contained "\<ethiopic-numeric\>"
syn region cssFunction contained matchgroup=cssFunctionName start="\<symbols\s*(" end=")" oneline keepend
