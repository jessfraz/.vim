" TODO: create cssMarqueeProp group and cssMarqueeAttr group
syn match cssFontProp contained "\<marquee-\(direction\|play-count\|speed\|style\)\>"
syn keyword cssFontAttr contained forward reverse infinite slide alternate
syn match cssFontAttr contained "\<marquee-\(line\|block\)\>"
