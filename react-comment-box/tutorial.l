(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")
(load "../react.l")
(load "../../picolisp-json/json.l")

(react~loadDeps)


# a simple DB model
(class +Comment +Entity)
(rel nr (+Key +Number))
(rel nm (+Ref +String))
(rel txt    (+String))

# open DB file
(pool "comments.db")

# if empty,  populate DB with comments
(unless (seq *DB)
   (new! '(+Comment) 
      'nr (genKey 'nr '+Comment)
      'nm "Bob" 
      'txt "Thanks for the wonderful blog post. Really helpful!" )
   (new! '(+Comment) 
      'nr (genKey 'nr '+Comment)
      'nm "Some Other Dude" 
      'txt "This is a comment from some other dude.") )

# API
#
# available at localhost:8080/!getComments
(de getComments ()
   (httpHead "application/json")
   (ht:Out T
      (prin "[")
      (prin
         (glue "," 
            (mapcar json~encode
               (make
                  (iter (tree 'nr '+Comment)
                     '((This)
                        (link
                           (list
                              (cons 'author (: nm))
                              (cons 'text (: txt)) ) ) ) ) ) ) ) )
      (prin "]") ) )

(de postComment (Author Text)
   (new! '(+Comment) 
      'nr (genKey 'nr '+Comment) 
      'nm Author 
      'txt Text) )
# end API

# web page
(de work ()
   (html 0 "React tutorial" "@lib.css" NIL
      (<div> '(id . content) NIL)
      (react~jsx "tutorial.js") ) )

# entry point
(de go ()
   (server 8080 "!work") )
