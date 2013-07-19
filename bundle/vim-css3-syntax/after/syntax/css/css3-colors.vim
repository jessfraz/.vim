syn region cssFunction contained matchgroup=cssFunctionName start="\<\(rgba\|hsla\=\)\s*(" end=")" oneline keepend
syn keyword cssColorProp contained opacity
syn match cssColor contained "\<currentColor\>"
