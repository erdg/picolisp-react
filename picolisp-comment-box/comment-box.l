# comment-box.l 
#
# The PL version of the React tutorial, without the React.
(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

# a simple DB model
(class +Comment +Entity)
(rel nr  (+Key +Number))  # id
(rel nm  (+Ref +String))  # author
(rel txt (+String))       # comment text

# open DB file
(pool "comments.db")

# if empty, populate DB with comments
(unless (seq *DB)
   (new! '(+Comment) 
      'nr (genKey 'nr '+Comment) 
      'nm "Roger" 
      'txt "Thanks for the great blog post!" )
   (new! '(+Comment) 
      'nr (genKey 'nr '+Comment) 
      'nm "Some Other Dude" 
      'txt "Duuuuuummmmmmmmmmbbbbbbbbbb" )
)

(de work ()
   (app)     
   (action  
      (html 0 "Comment Box" "@lib.css" NIL
         # for all comments in DB, display author in <h2> and text in <p>
         (for N (maxKey (tree 'nr '+Comment))                       
            (<h2> NIL (ht:Prin (get (db 'nr '+Comment N) 'nm)))    
            (<p>  NIL (ht:Prin (get (db 'nr '+Comment N) 'txt))) )
         # form to capture more comments
         (form NIL
            (gui '(+Var +Cue +TextField) '*Author "Your name"        20)
            (gui '(+Var +Cue +TextField) '*Text   "Say something..." 20 4)
            (gui '(+JS +Button) 
               "Submit"
               '(prog
                  (new! '(+Comment) 
                     'nr (genKey 'nr '+Comment) 
                     'nm  *Author 
                     'txt *Text )
                  (off *Author *Text) ) ) ) ) ) )

# entry point
(de go () (server 8080 "!work"))

