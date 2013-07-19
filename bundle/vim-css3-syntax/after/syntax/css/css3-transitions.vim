" TODO: create cssTransitionProp group and cssTransitionAttr group
syn match cssFontProp contained "\<transition\(-\(property\|duration\|timing-function\|delay\)\)\=\>"
syn keyword cssFontAttr contained linear
syn match cssFontAttr contained "\<ease\(-\(in\|out\|in-out\)\)\=\>"
syn match cssFontAttr contained "\<step-\(start\|end\)\>"
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(steps\|cubic-bezier\)\s*(" end=")" oneline keepend
