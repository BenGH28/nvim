
  (assignment
    right: (string
             (string_content) @injection.content (#any-contains? @injection.content
                                        "select"
                                        "from"
                                        "insert"
                                        "update"
                                        "delete"
                                        "create"
                                        "drop"
                                        "alter"
                                        "join"
                                        "where"
                                        "and"
                                        "or"
                                        "not"
                                        "null"
                                        "SELECT"
                                        "FROM"
                                        "INSERT"
                                        "UPDATE"
                                        "DELETE"
                                        "CREATE"
                                        "DROP"
                                        "ALTER"
                                        "JOIN"
                                        "WHERE"
                                        "AND"
                                        "OR"
                                        "NOT"
                                        "NULL")
             )
      (#set! injection.language "sql")
      (#set! injection.include-children)
    )
