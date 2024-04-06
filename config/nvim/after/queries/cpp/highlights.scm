; extends

(
    [
        (placeholder_type_specifier) ;cpp
    ] @primitive_override (#set! "priority" 204)
)


(
    [
        "namespace" ;cpp
        "template"
        "class"
        "typename"
    ] @keyword_override (#set! "priority" 201)
)

;cpp
(
    [
        "operator"
    ] @operator_name_override (#set! "priority" 201)
)

