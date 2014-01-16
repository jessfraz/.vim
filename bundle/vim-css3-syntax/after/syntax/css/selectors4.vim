syn match cssSelectorOp "[|]"
syn match cssPseudoClassId contained "\<\(active\|valid\|invalid\)-drop-target\>"
syn match cssPseudoClassId contained "\<placeholder-shown\>"
syn match cssPseudoClassId contained "\<user-error\>"
syn region cssPseudoClassLang matchgroup=cssPseudoClassId start=":dir(" end=")" oneline
