" TODO: create cssImagesProp group and cssImagesAttr group
syn match cssFontProp contained "\<object-\(fit\|position\)\>"
syn match cssFontProp contained "\<image-\(resolution\|orientation\)\>"
syn keyword cssFontAttr contained contain cover snap
syn match cssFontAttr contained "\<from-image\>"
syn match cssFontAttr contained "\<scale-down\>"
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(image\|\(repeating-\)\=\(linear\|radial\)-gradient\)\s*(" end=")" oneline keepend
