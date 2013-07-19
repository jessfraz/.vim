syn region cssMediaType contained start='(' end=')' contains=css.*Attr,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape nextgroup=cssMediaComma,cssMediaAnd,cssMediaBlock skipwhite skipnl
syn match cssMediaAnd "and" nextgroup=cssMediaType skipwhite skipnl
syn clear cssMediaBlock
syn region cssMediaBlock contained transparent matchgroup=cssBraces start='{' end='}' contains=cssTagName,cssSelectorOp,cssAttributeSelector,cssIdentifier,cssError,cssDefinition,cssPseudoClass,cssPseudoClassLang,cssComment,cssUnicodeEscape,cssClassName,cssURL
