; extends


(
    [
        (preproc_if . _ @preproc_cond (#set! "priority" 202) . _*)
        (preproc_elif . _ @preproc_cond (#set! "priority" 202) . _*)
        (preproc_ifdef . _ @preproc_cond (#set! "priority" 202) . _*)
    ]
)

(
    [
        "#include"
        (preproc_function_def)
        (preproc_def)
        (preproc_call)
        "#endif"
        "#else"
    ] @preproc_simple (#set! "priority" 202)
)

(
    [
        (primitive_type)
        (storage_class_specifier)
        ;(placeholder_type_specifier) ;cpp
    ] @primitive_override (#set! "priority" 204)
)

(
    [
        "struct"
        "const"
        "enum"
        ;"namespace" ;cpp
    ] @keyword_override (#set! "priority" 201)
)

;cpp
;(
;    [
;        "operator"
;    ] @operator_name_override (#set! "priority" 201)
;)


(
    [
        (comment)
    ] @comment_override

    (#set! "priority" 203)
)
