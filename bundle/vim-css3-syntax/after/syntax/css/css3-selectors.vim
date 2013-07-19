syn keyword cssPseudoClassId contained target scope current past future enabled disabled checked indeterminate default required optional root empty blank
syn match cssPseudoClassId contained "\<\(any\|local\)-link\>"
syn match cssPseudoClassId contained "\<\(in\|out-of\)-range\>"
syn match cssPseudoClassId contained "\<read-\(only\|write\)\>"
syn match cssPseudoClassId contained "\<first-of-type\>"
syn match cssPseudoClassId contained "\<last-\(child\|of-type\)\>"
syn match cssPseudoClassId contained "\<only-\(child\|of-type\)\>"
syn region cssPseudoClassLang matchgroup=cssPseudoClassId start=":\(not\|matches\|current\|local-link\|nth\(-last\)\=-\(child\|of-type\|match\|column\)\|column\)(" end=")" oneline
