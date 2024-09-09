;; return a sql string
(return_statement
  (string
    (string_content) @injection.content (#any-contains? @injection.content
                                         "ALTER" "AND" "CREATE" "DELETE" "DROP"
                                         "FROM" "INSERT" "JOIN" "NOT" "NULL" "OR" "SELECT"
                                         "TRUNCATE" "UPDATE" "WHERE" "alter" "and" "create"
                                         "delete" "drop" "from" "insert" "join" "not"
                                         "null" "or" "select" "truncate" "update" "where"))
  (#set! injection.language "sql")
  (#set! injection.include-children)
  )

;; returning a sql string with .format()
(return_statement
  (call
    function: (attribute
                object: (string
                          (string_content) @injection.content (#any-contains? @injection.content
                                                               "ALTER" "AND" "CREATE" "DELETE" "DROP" "FROM"
                                                               "INSERT" "JOIN" "NOT" "NULL" "OR" "SELECT"
                                                               "TRUNCATE" "UPDATE" "WHERE" "alter" "and"
                                                               "create" "delete" "drop" "from" "insert" "join"
                                                               "not" "null" "or" "select" "truncate" "update" "where"))
                )
    )
  (#set! injection.language "sql")
  (#set! injection.include-children)
  )

;; variable assignment but the string has a .format()
(assignment
  right: (call
           function: (attribute
                       object: (string
                                 (string_content) @injection.content (#any-contains? @injection.content
                                                                      "ALTER" "AND" "CREATE" "DELETE" "DROP"
                                                                      "FROM" "INSERT" "JOIN" "NOT" "NULL" "OR"
                                                                      "SELECT" "TRUNCATE" "UPDATE" "WHERE" "alter"
                                                                      "and" "create" "delete" "drop" "from" "insert"
                                                                      "join" "not" "null" "or" "select" "truncate"
                                                                      "update" "where"))
                       )
           )
  (#set! injection.language "sql")
  (#set! injection.include-children)
  )

;; regular variable assignment
(assignment
  right: (string
           (string_content) @injection.content (#any-contains? @injection.content
                                                "ALTER" "AND" "CREATE" "DELETE" "DROP"
                                                "FROM" "INSERT" "JOIN" "NOT" "NULL" "OR"
                                                "SELECT" "TRUNCATE" "UPDATE" "WHERE" "alter"
                                                "and" "create" "delete" "drop" "from" "insert"
                                                "join" "not" "null" "or" "select" "truncate"
                                                "update" "where"))
  (#set! injection.language "sql")
  (#set! injection.include-children)
  )
