" TODO: create cssSupports group and cssSupportsType group
syn match cssMedia "@supports\>" nextgroup=cssMediaType skipwhite skipnl
syn match cssMediaAnd "or" nextgroup=cssMediaType skipwhite skipnl
syn match cssMediaAnd "not" nextgroup=cssMediaType skipwhite skipnl
