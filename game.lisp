(defvar *current-room* 'living-room)

(defvar *rooms* 
  '(
    (living-room (you are in the living room. 
		  a wizard is snoring loudly on the couch.)) 

    (garden (you are in a beautiful garden. 
	     there is a well in front of you.
	     )
     )

    (attic (you are in the attic. there is a 
	    giant welding torch in the corner.
	    )
     )
    )
  )

(defvar *edges* '(
			   (living-room (garden west door) (attic upstairs ladder))
			   (attic (living room downstairs ladder))
			   (garden (living-room downstairs ladder))
			   )
  )

(defvar *objects-in-room*
  '((bucket living-room)
    (toothbrush living-room)
    (hanger attic)))

(defun describe-location ()
  (cadr (assoc *current-room* *rooms*)))

(defun current-room-filter (a)
  (eql (cadr a) *current-room*)
  )

(defun describe-object (obj)
  `(You see a ,(car obj) on the floor.)
  )

(defun describe-objects-in-room ()
  (apply #'append
	 (mapcar #'describe-object   
 		 (remove-if-not #'current-room-filter *objects-in-room*)
		 )
	 )
  )

(defun describe-move (move)
  `(There is a ,(car move) going ,(cadr move) from here.)
  )

(defun describe-possible-moves ()
  (apply #'append
	 (mapcar #'describe-move (cdr (assoc *current-room* *edges*)))
	 )
  )
       

(defun look()
  (append (describe-location)
	  (describe-possible-moves)
	  (describe-objects-in-room)
	  ))


	
