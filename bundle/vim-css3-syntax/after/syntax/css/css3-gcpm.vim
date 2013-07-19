syn region cssFunction contained matchgroup=cssFunctionName start="\<\(target-\(counter\|counters\|text\)\|symbols\)\s*(" end=")" oneline keepend
syn keyword cssGeneratedContentProp contained bleed marks
syn match cssGeneratedContentProp contained "\<bookmark-\(label\|level\|state\|target\)\>"
syn match cssGeneratedContentProp contained "\<float-offset\>"
syn match cssGeneratedContentProp contained "\<string-set\>"
syn keyword cssGeneratedContentAttr contained open closed crop cross
