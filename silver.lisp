;; The Mystery of Silver Mountain - Common Lisp version
;; from the Usborne book with the same name

(defvar *edges*            nil "links between the locations")
(defvar *item-locations*   nil "location of the items")
(defvar *current-location* nil "location id of the player")
(defvar *table*            nil "hash table with values per id")
(defvar *tunnel-forward*   nil "from tunnels to stalagmites")
(defvar *tunnel-backward*  nil "from stalagmites to tunnels")

;; association list of the locations
(defparameter *nodes*
  '((grave                              ; 1
     "in a half-dug grave"
     (e goblin-graveyard))

    (goblin-graveyard                   ; 2
     "in the goblin graveyard"
     (s rusty-gates)
     (w grave)
     (e hollow-tomb))

    (hollow-tomb                        ; 3
     "in a hollow tomb"
     (w goblin-graveyard)
     (e stalactites))

    (stalactites                        ; 4
     "near some stalactites and stalagmites"
     (w hollow-tomb)
     (e tunnels))

    (tunnels                            ; 5
     "in a maze of tunnels"
     (w stalactites)
     (e vaulted-cavern))

    (vaulted-cavern                     ; 6
     "in a vaulted cavern"
     (s inscribed-cavern)
     (w tunnels)
     (e glass-gates))

    (glass-gates                        ; 7
     "near some high glass gates"
     (s ornate-fountain)
     (w vaulted-cavern)
     (e palace-entrance))

    (palace-entrance                    ; 8
     "in the entrance hall to the palace"
     (s dank-corridor)
     (e sentry-post))

    (sentry-post                        ; 9
     "by a grarg sentry post"
     (w palace-entrance)
     (e guard-room))

    (guard-room                         ; 10
     "in the guard room"
     (s palace-kitchens)
     (w sentry-post))

    (marshy-inlet                       ; 11
     "by a marshy inlet"
     (s old-kiln))

    (rusty-gates                        ; 12
     "near some rusty gates"
     (n goblin-graveyard))

    (gamekeepers-cottage                ; 13
     "in the gamekeepers cottage"
     (s disused-waterwheel)
     (e misty-pool))

    (misty-pool                         ; 14
     "by a misty pool"
     (s sluice-gates)
     (w gamekeepers-cottage))

    (high-walled-garden                 ; 15
     "in a high-walled garden"
     (s between-boulders))

    (inscribed-cavern                   ; 16
     "in an inscribed cavern"
     (n vaulted-cavern)
     (w high-walled-garden))

    (ornate-fountain                    ; 17
     "by an ornate fountain"
     (n glass-gates))

    (dank-corridor                      ; 18
     "in a dank corridor"
     (n palace-entrance))

    (long-gallery                       ; 19
     "in the long gallery"
     (s banqueting-hall)
     (e palace-kitchens))

    (palace-kitchens                    ; 20
     "in the kitchens of the palace"
     (n guard-room)
     (s palace-battlements)
     (w long-gallery))

    (old-kiln                           ; 21
     "by an old kiln"
     (n marshy-inlet)
     (s island-shore))

    (overgrown-track                    ; 22
     "on an overgrown track"
     (e disused-waterwheel))

    (disused-waterwheel                 ; 23
     "by a disused waterwheel"
     (n gamekeepers-cottage)
     (s barren-countryside)
     (w overgrown-track))

    (sluice-gates                       ; 24
     "by some sluice gates"
     (n misty-pool))

    (between-boulders                   ; 25
     "in a gap between some boulders"
     (n high-walled-garden)
     (s frozen-pond)
     (e perilous-path))

    (perilous-path                      ; 26
     "on a perilous path"
     (w between-boulders)
     (e silver-bell))

    (silver-bell                        ; 27
     "by a silver bell in the rock"
     (w perilous-path))

    (palace-dungeons                    ; 28
     "in the dungeons of the palace"
     (s wine-cellar))

    (banqueting-hall                    ; 29
     "in a banqueting hall"
     (n long-gallery)
     (s hall-of-tapestries))

    (palace-battlements                 ; 30
     "on the palace battlements"
     (n palace-kitchens))

    (island-shore                       ; 31
     "on an island shore"
     (n old-kiln)
     (s rough-water)
     (e beached-ketch))

    (beached-ketch                      ; 32
     "by a beached ketch"
     (w island-shore))

    (barren-countryside                 ; 33
     "in some barren countryside"
     (n disused-waterwheel)
     (s outside-windmill))

    (upper-windmill                     ; 34
     "by some sack on the upper floor"
     (d lower-windmill))

    (frozen-pond                        ; 35
     "on a small frozen pond"
     (n between-boulders)
     (s icy-path)
     (e mountain-hut))

    (mountain-hut                       ; 36
     "near a mountain hut"
     (s scree-slope)
     (w frozen-pond))

    (row-of-casks                       ; 37
     "by a row of casks"
     (e wine-cellar))

    (wine-cellar                        ; 38
     "in a wine cellar"
     (n palace-dungeons)
     (w row-of-casks))

    (hall-of-tapestries                 ; 39
     "in the hall of tapestries"
     (n banqueting-hall)
     (s mosaic-hall))

    (dusty-library                      ; 40
     "in a dusty library"
     (s silver-throne))

    (rough-water                        ; 41
     "in some rough water"
     (n island-shore)
     (s lake-middle))

    (ploughed-field                     ; 42
     "in a ploughed field"
     (e outside-windmill))

    (outside-windmill                   ; 43
     "outside a windmill"
     (n barren-countryside)
     (s pitted-track)
     (w ploughed-field)
     (e lower-windmill))

    (lower-windmill                     ; 44
     "on the lower floor of the mill"
     (u upper-windmill)
     (w outside-windmill))

    (icy-path                           ; 45
     "on an icy path"
     (u frozen-pond)
     (d above-glacier))

    (scree-slope                        ; 46
     "on a scree slope"
     (n mountain-hut)
     (s fallen-oak))

    (silver-chamber                     ; 47
     "in the silver chamber"
     (e wizards-lair))

    (wizards-lair                       ; 48
     "in the wizard's lair"
     (s cobwebby-room)
     (w silver-chamber))

    (mosaic-hall                        ; 49
     "in a mosaic-floored hall"
     (n hall-of-tapestries)
     (s ogbans-chamber)
     (e silver-throne))

    (silver-throne                      ; 50
     "in the silver throne room"
     (n dusty-library)
     (w mosaic-hall))

    (lake-middle                        ; 51
     "in the middle of the lake"
     (n rough-water)
     (e lake-edge))

    (lake-edge                          ; 52
     "on the edge of an icy lake"
     (w lake-middle)
     (e pitted-track))

    (pitted-track                       ; 53
     "on a pitted track"
     (n outside-windmill)
     (s woodmans-hut)
     (w lake-edge))

    (high-pinnacle                      ; 54
     "on a high pinnacle"
     (e above-glacier))

    (above-glacier                      ; 55
     "above a glacier"
     (n icy-path)
     (w high-pinnacle))

    (fallen-oak                         ; 56
     "near a huge fallen oak"
     (s dark-wood))

    (turret-room                        ; 57
     "in a turret room with a slot machine"
     (e cobwebby-room))

    (cobwebby-room                      ; 58
     "in a cobwebby room"
     (n wizards-lair)
     (w turret-room)
     (e ogbans-chamber))

    (ogbans-chamber                     ; 59
     "by a safe in ogban's chamber"
     (n mosaic-hall)
     (w cobwebby-room))

    (attic-cupboard                     ; 60
     "by a cupboard in a corner"
     (s attic-bedroom))

    (narrow-passage                     ; 61
     "in a narrow passage"
     (s well-bottom)
     (e small-cave))

    (small-cave                         ; 62
     "in a small cave"
     (s deep-well)
     (w narrow-passage))

    (woodmans-hut                       ; 63
     "in a woodman's hut"
     (n pitted-track)
     (s campfire)
     (e valley))

    (valley                             ; 64
     "on the side of a wooded valley"
     (w woodmans-hut)
     (e valley-stream))

    (valley-stream                      ; 65
     "near a stream in a valley bottom"
     (s west-bridge)
     (w valley))

    (dark-wood                          ; 66
     "in a deep dark wood"
     (n fallen-oak)
     (e shady-hollow))

    (shady-hollow                       ; 67
     "in a shady hollow"
     (w dark-wood)
     (e stone-circle))

    (stone-circle                       ; 68
     "by an ancient stone circle"
     (s winding-road)
     (w shady-hollow)
     (e small-stable))

    (small-stable                       ; 69
     "in a small stable"
     (s rustic-village)
     (w stone-circle))

    (attic-bedroom                      ; 70
     "in an attic bedroom"
     (n attic-cupboard)
     (d white-cottage))

    (well-bottom                        ; 71
     "in a damp well bottom")

    (deep-well                          ; 72
     "by the top of a deep well"
     (e campfire))

    (campfire                           ; 73
     "by a burnt-out campfire"
     (n woodmans-hut)
     (w deep-well)
     (e small-orchard))

    (small-orchard                      ; 74
     "in a small orchard"
     (w campfire)
     (e west-bridge))

    (west-bridge                        ; 75
     "at the end of a bridge"
     (n valley-stream)
     (w small-orchard)
     (e east-bridge))

    (east-bridge                        ; 76
     "at the end of a bridge"
     (w west-bridge)
     (e crossroads))

    (crossroads                         ; 77
     "at a crossroads"
     (w east-bridge)
     (e winding-road))

    (winding-road                       ; 78
     "on a winding road"
     (n stone-circle)
     (w crossroads)
     (e rustic-village))

    (rustic-village                     ; 79
     "in a village of rustic houses"
     (n small-stable)
     (w winding-road)
     (e white-cottage))

    (white-cottage                      ; 80
     "in a white cottage"
     (u attic-bedroom)
     (w rustic-village))))

(defun make-map (graph)
  (flet ((dot-name (exp)
           (substitute-if #\_
                          (complement #'alphanumericp)
                          (prin1-to-string exp))))
    ;; start
    (princ "digraph {")
    (fresh-line)

    ;; nodes
    (mapc (lambda (node)
            (format t "~a[label=\"~a\"];~%"
                    (dot-name (car node))
                    (cadr node)))
          graph)

    ;; edges
    (mapc (lambda (node)
            (mapc (lambda (edge)
                    (format t "~a->~a[label=\"~a\"];~%"
                            (dot-name (car node))
                            (dot-name (cadr edge))
                            (car edge)))
                  (cddr node)))
          graph)

    ;; end
    (princ "}")))

;; association list of the gettable items
(defparameter *items*
  '((coins "coins" "some" white-cottage :hidden)               ; 1
    (sheet "sheet" "a" attic-bedroom :hidden)                  ; 2
    (boots "boots" "some" attic-cupboard :hidden)              ; 3
    (horseshoe "horseshoe" "a" small-stable :hidden)           ; 4
    (apples "apples" "some" small-orchard :hidden)             ; 5
    (bucket "bucket" "a" deep-well)                            ; 6
    (axe "axe" "an" woodmans-hut)                              ; 7
    (boat "boat" "a" lake-edge)                                ; 8
    (phial "phial" "a" palace-kitchens :hidden)                ; 9
    (reeds "reeds" "some" marshy-inlet)                        ; 10
    (bone "bone" "a" grave)                                    ; 11
    (shield "shield" "a" misty-pool :hidden)                   ; 12
    (planks "planks" "some" mountain-hut :hidden)              ; 13
    (rope "rope" "a" high-pinnacle)                            ; 14
    (ring "ring" "a" narrow-passage)                           ; 15
    (jug "jug" "a" old-kiln :hidden)                           ; 16
    (net "net" "a" beached-ketch :hidden)                      ; 17
    (sword "sword" "a" guard-room)                             ; 18
    (silver-plate "silver plate" "a" silver-throne)            ; 19
    (uniform "uniform" "a" banqueting-hall :hidden)            ; 20
    (key "key" "a" ogbans-chamber :hidden)                     ; 21
    (seeds "seeds" "some" upper-windmill :hidden)              ; 22
    (lamp "lamp" "a" gamekeepers-cottage)                      ; 23
    (bread "bread" "some" white-cottage)                       ; 24
    (brooch "brooch" "a" palace-battlements)                   ; 25
    (matches "matches" "some" nil)                             ; 26
    (stone-of-destiny "stone of destiny" "the" silver-chamber) ; 27
    (apple "apple" "an" small-orchard)))                       ; 28

;; association list of the static items
(defparameter *words*
  '((bed "bed")                                                ; 29
    (cupboard "cupboard")                                      ; 30
    (bridge "bridge")                                          ; 31
    (trees "trees")                                            ; 32
    (sail "sail")                                              ; 33
    (kiln "kiln")                                              ; 34
    (ketch "ketch")                                            ; 35
    (bricks "bricks")                                          ; 36
    (windmill "windmill")                                      ; 37
    (sacks "sacks")                                            ; 38
    (boar "ogbans boar")                                       ; 39
    (wheel "wheel")                                            ; 40
    (pony "pony")                                              ; 41
    (gravestones "gravestones")                                ; 42
    (pool "pool")                                              ; 43
    (gates "gates")                                            ; 44
    (handle "handle")                                          ; 45
    (hut "hut")                                                ; 46
    (vine "vine")                                              ; 47
    (inscriptions "inscriptions")                              ; 48
    (troll "troll")                                            ; 49
    (rubble "rubble")                                          ; 50
    (hound "hound")                                            ; 51
    (fountain "fountain")                                      ; 52
    (circle "circle")                                          ; 53
    (mosaics "mosaics")                                        ; 54
    (books "books")                                            ; 55
    (casks "casks")                                            ; 56
    (well "well")                                              ; 57
    (walls "walls")                                            ; 58
    (rats "rats")                                              ; 59
    (safe "safe")                                              ; 60
    (cobwebs "cobwebs")                                        ; 61
    (coin "coin")                                              ; 62
    (bell "bell")                                              ; 63
    (up-silver-plate "up silver plate")                        ; 64
    (stones "stones")                                          ; 65
    (kitchens "kitchens")                                      ; 66
    (goblet "goblet")                                          ; 67
    (wine "wine")                                              ; 68
    (grargs "grargs")                                          ; 69
    (door "door")                                              ; 70
    (awake "awake")                                            ; 71
    (guide "guide")                                            ; 72
    (protect "protect")                                        ; 73
    (lead "lead")                                              ; 74
    (help "help")                                              ; 75
    (chest "chest")                                            ; 76
    (water "water")                                            ; 77
    (stables "stables")                                        ; 78
    (sluice-gates "sluice gates")                              ; 79
    (pot "pot")                                                ; 80
    (statue "statue")                                          ; 81
    (pinnacle "pinnacle")                                      ; 82
    (music "music")                                            ; 83
    (magic-words "magic words")                                ; 84
    (misty-pool "misty pool")                                  ; 85
    (well-boom "well bottom")                                  ; 86
    (old-kiln "old kiln")                                      ; 87
    (mountain-hut "mountain hut")))                            ; 88

;; room functions
(defun location-name (id)
  (cadr (assoc id *nodes*)))

(defun location-exits (id)
  (gethash id *edges*))

(defun can-go (loc dir)
  (find dir (mapcar #'car (location-exits loc))))

(defun set-location-exits (id exits)
  (setf (gethash id *edges*) exits))

;; table functions
(defun table-get (id)
  (gethash id *table*))

(defun table-set (id value)
  (setf (gethash id *table*) value))

;; item functions
(defun find-item (name)
  "Find an item id by its name"
  (labels ((iterate (lst)
             (cond ((null lst) lst)
                   ((string= (cadar lst) name)
                    (car (car lst)))
                   (t
                    (iterate (cdr lst))))))
    (or (iterate *items*)
        (iterate *words*))))

(defun item-unqualified-name (id)
  (cadr (assoc id *items*)))

(defun item-name (id)
  (let ((item (assoc id *items*)))
    (and item
         (format nil "~a ~a" (caddr item) (cadr item)))))

(defun item-location (id)
  (gethash id *item-locations*))

(defun set-item-location (id location)
  (setf (gethash id *item-locations*) location))

(defun item-in-pocket (id)
  (eq (item-location id) 'pocket))

(defun item-hidden (id)
  (table-get id))

;; table entries by index
;; 29: wearing-boots (invisible)
;; 30: using-sheet (for boot or...?)
;; 31: boat-saved
;; 32: boar-caught
;; 33: pool-empty
;; 34: jug-filled
;; 35: ghost-freed
;; 36: <an item by adding a S>
;; 37: seeds-planted
;; 38: vine-grown
;; 39: boots-time (if > 5 the boots are worn out)
;; 40: sheet-tied
;; 41: safe-code (between [100..999] initialized at the start)
;; 42: rings-needed (between [2..4] initialized at the start)
;; 43: door-burned
;; 44: money (initialized to 4 at the start)
;; 45: rubble-moved (to pass pile rubble)
;; 46: hound-distracted to hound
;; 47: wine-poisoned
;; 48: grarg-sleeping
;; 49: <inside inventory subroutine>
;; 50: lamp-lit
;; 51: wearing-uniform
;; 52: third-word (between [0..2] decides the third word and location)
;; 53: rope-tied
;; 54: throne-open
;; 55: grarg-patrol (approaching)
;; 56: quest-failed (U R DEAD)
;; 57: initially set to 58 cobwebby-room (ignore)
;; 58: initially set to 54 high-pinnacle (ignore)
;; 59: initially set to 15 high-walled-garden (ignore)
;; 60: mountain-awaken
;; 61: towers-fallen
;; 62: quest-won
;; 63: wizard-dead
;; 64: troll-paid
;; 65: rats-fed (given bread or apples)
;; 66: webs-cleared (swinging the sword)
;; 67: water-time (if == 10 the boats sunks) (set in the game loop)
;; 68: ogban-dead
;; 69: <current room>
;; 70: door-unlocked (in wizards-lair)

;; get a line with a prompt
(defun input (prompt)
  (fresh-line)
  (princ prompt)
  (force-output)
  (string-trim " " (read-line *standard-input* nil)))

;; tunnels mini game
;; TODO: make it asynchronous
(defun tunnels (dir)
  (let ((goal (if (eq dir 'w) *tunnel-forward* *tunnel-backward*)))
    (labels ((move (count last)
               (princ "You are lost in the tunnels.")
               (terpri)
               (let* ((c (char (input (if (> count 15)
                                          "Which way (n, s, w, e or g to give up!)? "
                                          "Which way (n, s, w or e)? "))
                               0))
                      (dir (cond ((find c '(#\n #\N)) 'n)
                                 ((find c '(#\s #\S)) 's)
                                 ((find c '(#\w #\W)) 'w)
                                 ((find c '(#\e #\E)) 'e)
                                 ((find c '(#\g #\G)) 'g)))
                      (comb (append (cdr last) (cons dir nil))))
                 (cond ((eq dir 'g)
                        (table-set 'quest-failed t))
                       ((equal goal comb)
                        nil)
                       (t
                        (move (1+ count) comb))))))
      (move 0 '(u u u u u u u u)))))

;; verb functions n e s w u d (line 800)
(defun go-handler (loc dir default)
  (let ((exits (location-exits loc)))
    (cond ((and (or (and (eq loc 'west-bridge) (eq dir 'e))
                    (and (eq loc 'east-bridge) (eq dir 'w)))
                (not (table-get 'troll-paid)))
           "A troll stops you crossing.")
          ((and (table-get 'grarg-patrol)
                (not (or (table-get 'wearing-uniform)
                         (table-get 'wearing-boots))))
           (table-set 'quest-failed t)
           "Grargs have got you!")
          ((and (eq loc 'banqueting-hall)
                (not (table-get 'grarg-sleeping))
                (not (or (table-get 'wearing-uniform)
                         (table-get 'wearing-boots))))
           "Grargs will see you!")
          ((and (find loc '(campfire ploughed-field sentry-post guard-room))
                (not (or (table-get 'wearing-uniform)
                         (table-get 'wearing-boots))))
           (table-set 'grarg-patrol t)
           "A grarg patrol approaches.")
          ((and (item-in-pocket 'boat)
                (or (and (eq loc 'lake-edge) (eq dir 'e))
                    (and (eq loc 'island-shore) (not (eq dir 's)))))
           "The boat is too heavy.")
          ((and (not (item-in-pocket 'boat))
                (or (and (eq loc 'lake-edge) (eq dir 'w))
                    (and (eq loc 'island-shore) (eq dir 's))))
           "You cannot swim.")
          ((and (eq loc 'lake-edge)
                (eq dir 'w)
                (item-in-pocket 'boat)
                (not (table-get 'using-sheet)))
           "No power!")
          ((and (eq loc 'rough-water)
                (eq dir 's)
                (not (table-get 'boat-saved)))
           "The boat is sinking!")
          ((and (eq loc 'barren-countryside)
                (eq dir 'n)
                (not (table-get 'boar-caught)))
           "Ogban's boar blocks your path.")
          ((and (or (and (eq loc 'hollow-tomb) (eq dir 'e))
                    (and (eq loc 'stalactites) (eq dir 'w)))
                (not (table-get 'rubble-moved)))
           "A pile of rubble blocks your path")
          ((and (eq loc 'frozen-pond)
                (not (eq (item-location 'planks) loc)))
           "The ice is breaking!")
          ((and (eq loc 'stalactites) (eq dir 'w))
           "The passage is too steep.")
          ((and (eq loc 'glass-gates) (eq dir 'e)
                (not (table-get 'hound-distracted)))
           "A huge hound bars your way.")
          ((and (or (eq loc 'row-of-casks)
                    (eq loc 'wine-cellar))
                (not (table-get 'lamp-lit)))
           "It is too dark.")
          ((and (eq loc 'mosaic-hall)
                (eq dir 'e)
                (not (table-get 'throne-open)))
           "Mysterious forces hold you back.")
          ((and (eq loc 'mosaic-hall)
                (eq dir 's)
                (not (table-get 'ogban-dead)))
           (table-set 'quest-failed t)
           "You met Ogban!!!")
          ((and (eq loc 'wine-cellar)
                (not (table-get 'rats-fed)))
           "Rats nibble your ankles.")
          ((and (eq loc 'cobwebby-room)
                (or (eq dir 'n)
                    (eq dir 'w))
                (not (table-get 'webs-cleared)))
           "You get caught in the webs!")
          ((and (eq loc 'wizards-lair)
                (eq dir 'w)
                (not (table-get 'door-unlocked)))
           "The door does not open.")
          ((and (eq loc 'row-of-casks)
                (eq dir 'w)
                (find dir (mapcar #'car (location-exits loc))))
           (setf *current-location* 'shady-hollow)
           "The passage was steep!")
          (t
           ;; solve the tunnels maze
           (when (and (eq loc 'tunnels)
                      (find dir '(e w)))
             (tunnels dir))

           ;; reset the bridge fee
           (table-set 'troll-paid nil)

           ;; update ogban's status
           (when (and (eq loc 'dusty-library)
                      (table-get 'wine-poisoned))
             (table-set 'ogban-dead t))

           ;; grargs go to sleep
           (when (and (eq loc 'banqueting-hall)
                      (eq dir 's))
             (table-set 'grarg-sleeping t)
             (table-set 'uniform nil))

           ;; reset the dog status after entering the palace
           (when (and (eq loc 'palace-entrance)
                      (eq dir 'e))
             (table-set 'hound-distracted nil))

           ;; set the new location
           (setf *current-location* (or (cadr (assoc dir exits)) loc))

           ;; generate the message
           (cond ((eq *current-location* loc)
                  "You cannot go that way.")
                 ((and (table-get 'wearing-boots)
                       (> (table-get 'boots-time) 5))
                  (table-set 'wearing-boots nil)
                  (set-item-location 'boots nil)
                  "Boots have worn out.")
                 (t
                  ;; update the boots
                  (when (table-get 'wearing-boots)
                    (table-set 'boots-time (1+ (table-get 'boots-time))))
                  (if (or (and (eq loc 'west-bridge)
                               (eq dir 'e))
                          (and (eq loc 'east-bridge)
                               (eq dir 'w)))
                      "OK, you crossed."
                      "OK.")))))))

;; 1220
(defun inventory-handler (loc item default)
  (let* ((items (remove-if-not #'item-in-pocket (mapcar #'car *items*)))
         ;; don't show the single apple if we have many happles
         (items (if (item-in-pocket 'apples) (remove 'apple items) items))
         ;; show a single coin if we have one coin
         (items (mapcar (lambda (item)
                          (if (and (eq item 'coins)
                                   (= (table-get 'money) 1))
                              "a coin"
                              (item-name item)))
                        items)))
    (format nil "You have ~:[nothing~;~{~a~^, ~}~]." items items)))

;; 1290
(defun get-handler (loc item default)
  (let*  ((items (mapcar #'car *items*))
          (carrying (remove-if-not #'item-in-pocket items)))
    (cond ((and (eq loc 'valley-stream)
                (eq item 'water))
           "How?")
          ((and (or (eq loc 'rough-water)
                    (eq loc 'lake-middle))
                (eq item 'water))
           (fill-handler loc 'jug default))
          ((eq item 'sacks)
           "Too heavy!")
          ((and (eq item 'horseshoe)
                (not (table-get 'door-burned)))
           "It's firmly nailed on!")
          ((> (length carrying) 13)
           "You cannot carry any more.")
          ((not (find item items))
           "You cannot get it.")        ;TODO: fix by passing the string item
          ((not (eq (item-location item) loc))
           "It's not here!")
          ((item-hidden item)
           "What?")                     ;TODO: fix by passing the string item
          ((find item carrying)
           "You already have it.")
          (t
           (set-item-location item 'pocket)

           ;; if you pick one apple the other apples disappear
           (when (eq item 'apple)
             (set-item-location 'apples nil))

           ;; if you pick all the apples you pick also the single
           ;; apple
           (when (eq item 'apples)
             (set-item-location 'apple 'pocket))

           ;; update the throne-open status
           (table-set 'throne-open (and (item-in-pocket 'horseshoe)
                                        (item-in-pocket 'shield)
                                        (item-in-pocket 'ring)))

           ;; remove the sheet in the palace-entrance
           (when (and (eq loc 'palace-entrance)
                      (table-get 'using-sheet))
             ;; NOTE: shouldn't we also disable 'using-sheet?
             (set-item-location 'sheet 'pocket))

           ;; if you get the item you alsi disable using sheet
           (when (eq item 'sheet)
             (table-set 'using-sheet nil))

           (when (eq loc 'goblin-graveyard)
             (table-set 'using-sheet nil))

           (format nil "You have the ~a."
                   (item-unqualified-name item))))))

;; 1470
(defun examine-handler (loc item default)
  (cond ((not item)
         "You see what you might expect!")
        ((find item '(hut mountain-hut))
         (enter-handler loc item default))
        ((and (eq loc 'white-cottage)
              (eq item 'chest))
         "It is empty.")
        ((and (eq loc 'white-cottage)
              (eq item 'pot))
         (table-set 'coins nil)
         "Aha!")
        ((and (eq loc 'attic-bedroom)
              (eq item 'bed))
         (table-set 'sheet nil)
         "OK.")
        ((eq item 'uniform)
         (set-item-location 'matches 'pocket)
         "Matches in pocket.")
        ((and (eq loc 'inscribed-cavern)
              (eq item 'inscriptions))
         (format nil "There are some letters '~a'."
                 (apply #'concatenate
                        (cons 'string
                              (mapcar #'prin1-to-string *tunnel-forward*)))))
        ((and (eq loc 'small-orchard)
              (eq item 'trees))
         (table-set 'apples nil)
         "They are apple trees.")
        ((and (eq loc 'old-kiln)
              (find item '(kiln old-kiln)))
         (table-set 'jug nil)
         "OK.")
        ((eq item 'ketch)
         (table-set 'net nil)
         "It's fishy.")
        ((and (eq loc 'upper-windmill)
              (eq item 'sacks))
         (table-set 'seeds nil)
         "OK.")
        ((and (eq loc 'goblin-graveyard)
              (eq item 'gravestones))
         "A faded inscription.")
        ((and (eq loc 'goblin-graveyard)
              (eq item 'inscriptions))
         "A faded word 'M R H S'.")
        ((and (eq loc 'misty-pool)
              (find item '(pool misty-pool)))
         (cond ((not (table-get 'pool-empty))
                "A glimmering from the depths.")
               (t
                (table-set 'shield nil)
                "Something here...")))
        ((and (eq loc 'sluice-gates)
              (find item '(gates sluice-gates)))
         "There is a handle.")
        ((eq item 'phial)
         "The label read 'poison'.")
        ((and (eq loc 'dusty-library)
              (eq item 'books))
         (format nil "Magic words lie at the crossroads, the fountain and ~a."
                 (location-name (nth (table-get 'third-word)
                                     '(stone-circle high-pinnacle high-walled-garden)))))
        ((and (eq loc 'banqueting-hall)
              (eq item 'grargs)
              (table-get 'grarg-sleeping))
         "Very ugly!")
        ((and (eq loc 'well-bottom)
              (find item '(walls well-bottom)))
         "There are loose bricks.")
        ((eq loc 'mosaic-hall)
         "Very interesting!")
        ((find item '(fountain statue pinnacle))
         "Interesting!")
        ((and (eq loc 'small-stable)
              (eq item 'stables))
         "There is a wooden door.")
        ((and (eq loc 'small-stable)
              (eq item 'door))
         (table-set 'horseshoe nil)
         "You found something.")
        ((and (eq loc 'palace-kitchens)
              (eq item 'kitchens))
         "A large cupboard in the corner.")
        ((and (eq loc 'stone-circle)
              (find item '(stones circle)))
         "There are nine stones.")
        (t
         "Nothing special.")))

;; 1750
(defun give-handler (loc item default)
  (cond ((and (eq loc 'valley) (eq item 'brooch))
         (set-item-location item nil)
         (format nil "He takes it and says '~a' rings are needed." (table-get 'rings-needed)))
        ((eq item 'brooch)
         "He gives it back.")
        ((and (eq item 'coin)
              (= (table-get 'money) 0))
         "You have run out!")
        ((find loc '(west-bridge east-bridge))
         (cond ((and (eq item 'coin)
                     (item-in-pocket 'coins)
                     (> (table-get 'money) 0))
                (table-set 'troll-paid t)
                (let ((amount (1- (table-get 'money))))
                  (table-set 'money amount)
                  (when (= amount 0)
                    (set-item-location 'coins nil)))
                "He takes it.")
               ((and (eq item 'coins)
                     (item-in-pocket 'coins))
                (table-set 'troll-paid t)
                (table-set 'money 0)
                (set-item-location 'coins nil)
                "He takes them all!")
               (t
                "He does not want it.")))
        ((and (eq loc 'overgrown-track)
              (item-in-pocket 'apple)
              (find item '(apples apple)))
         ;; if no other apple in pocket, you lose the apple
         (when (not (item-in-pocket 'apples))
           (set-item-location 'apple nil))
         (setf *current-location* 'rusty-gates)
         "He leads you north.")
        ((and (eq loc 'rusty-gates)
              (item-in-pocket 'apple)
              (find item '(apples apple)))
         (setf *current-location* 'overgrown-track)
         "He leads you south.")
        ((and (eq loc 'glass-gates)
              (eq item 'bone))
         (set-item-location item nil)
         (table-set 'hound-distracted t)
         "He is distracted.")
        ((and (find loc '(glass-gates barren-countryside)))
         (set-item-location item nil)
         "He eats it!")
        ((and (eq loc 'wine-cellar)
              (find item '(apples bread)))
         (set-item-location item nil)
         (table-set 'rats-fed t)
         "They scurry away.")
        (t default)))

;; 1890
(defun say-handler (loc item default)
  (let ((loc *current-location*))
    (cond ((eq item 'magic-words)
           "You must say them one by one!")
          ((or (not (eq loc 'silver-chamber))
               (not (find item '(awake guide protect lead help)))
               (not (item-in-pocket 'stone-of-destiny)))
           "You said it.")
          ((and (eq item 'awake)
                (not (table-get 'mountain-awaken)))
           (table-set 'mountain-awaken t)
           "The mountain rumbles!")
          ((and (eq item 'guide)
                (table-get 'mountain-awaken)
                (not (table-get 'towers-fallen)))
           (table-set 'towers-fallen t)
           "Towers fall down!")
          ((and (eq item (nth (table-get 'third-word)
                              '(protect lead help)))
                (table-get 'mountain-awaken)
                (table-get 'towers-fallen))
           (table-set 'quest-won t)
           default)
          (t
           (table-set 'quest-failed t)
           "The wrong Sacred Word!"))))

;; 1960
(defun pick-handler (loc item default)
  (cond ((or (eq item 'apples)
             (eq item 'reeds))
         (get-handler loc item default))
        (t
         default)))

;; 1980
(defun wear-handler (loc item default)
  (cond ((eq item 'boots)
         (table-set 'wearing-boots t)
         (table-set 'grarg-patrol nil)
         "You are invisible.")
        ((eq item 'uniform)
         (table-set 'wearing-uniform t)
         (table-set 'grarg-patrol nil)
         "You are disguised.")
        (t
         default)))

;; 2010
(defun tie-handler (loc item default)
  (cond ((and (eq loc 'deep-well)
              (eq item 'rope))
         (set-item-location 'rope 'deep-well)
         (table-set 'rope-tied t)
         "It is tied.")
        ((and (eq loc 'deep-well) (eq item 'sheet))
         (set-item-location 'sheet 'deep-well)
         (table-set 'sheet-tied t)
         "OK.")
        ((or (eq item 'rope)
             (eq item 'sheet))
         "Nothing to tie with.")
        (t
         default)))

;; 2050
(defun climb-handler (loc item default)
  (cond ((and (eq loc 'high-walled-garden)
              (eq item 'vine)
              (table-get 'vine-grown))
         (setf *current-location* 'inscribed-cavern)
         "All right.")
        ((and (eq loc 'high-pinnacle)
              (eq item 'rope)
              (set-item-location 'rope 'high-pinnacle))
         "You are at the top.")
        ((and (eq loc 'deep-well)
              (eq item 'rope)
              (table-get 'rope-tied))
         (setf *current-location* 'well-bottom)
         "Going down.")
        ((and (eq loc 'well-bottom)
              (eq item 'sheet)
              (table-get 'sheet-tied))
         (set *current-location* 'deep-well)
         (set-item-location item nil)
         (table-set 'sheet-tied nil)
         "It is torn.")
        ((and (eq loc 'well-bottom)
              (eq item 'rope)
              (table-get 'rope-tied))
         (set-item-location item loc)
         (table-set 'rope-tied nil)
         "It falls down-BUMP!")
        ((or (eq item 'rope)
             (eq item 'sheet))
         "Not attached to anything!")
        (t
         default)))

;; 2120
(defun use-handler (loc item default)
  (cond ((and (eq loc 'lake-edge)
              (eq item 'sheet))
         (table-set 'using-sheet t)
         "OK.")
        ((find item '(coins apples bone bread apple coin))
         (give-handler loc item default))
        ((and (eq loc 'rough-water)
              (eq item 'bucket))
         (table-set 'boat-saved t)
         "You have kept afloat.")
        ((and (eq loc 'rough-water)
              (eq item 'jug))
         "It is not bigh enough!")
        ((find item '(axe sword))
         (swing-handler loc item default))
        ((eq item 'planks)
         (drop-handler loc item default))
        ((eq item 'silver-plate)
         (show-handler loc item default))
        ((eq item 'reeds)
         (make-handler loc item default))
        ((find item '(bucket jug))
         (fill-handler loc item default))
        (t
         default)))

;; 2220
(defun open-handler (loc item default)
  (cond ((find item '(sacks chest))
         (examine-handler loc item default))
        ((and (eq loc 'palace-kitchens)
              (eq item 'cupboard))
         (table-set 'phial nil)
         "OK.")
        ((and (eq loc 'attic-cupboard)
              (eq item 'cupboard))
         (table-set 'boots nil)
         "OK.")
        ((or (and (eq loc 'sluice-gates)
                  (eq item 'gates))
             (and (eq loc 'dank-corridor)
                  (eq item 'door)))
         "You are not strong enough.")
        ((and (eq loc 'row-of-casks)
              (eq item 'casks))
         (set-location-exits loc '((e wine-cellar)
                                   (w mountain-hut)))
         "A passage!")
        ((and (eq loc 'ogbans-chamber)
              (eq item 'safe))
         (let ((code (parse-integer (input "What is the code? "))))
           (cond ((= code (table-get 'safe-code))
                  (table-set 'key nil)
                  "It opens.")
                 (t "WRONG!"))))
        ((and (eq loc 'small-stable)
              (eq item 'door))
         "It falls off its hinges.")
        ((and (eq loc 'wizards-lair)
              (eq item 'door))
         "It is locked.")
        (t default)))

;; 2310
(defun burn-handler (loc item default)
  (let ((have-matches (item-in-pocket 'matches)))
    (cond ((and (eq item 'matches)
                (not have-matches))
           "No matches.")
          ((and (eq loc 'wine-cellar)
                (eq item 'matches))
           "Not bright enough.")
          ((and (or (eq item 'lamp)
                    (and (eq loc 'small-stable)
                         (eq item 'door)))
                (not have-matches))
           "No matches.")
          ((and (eq item 'lamp)
                have-matches)
           (table-set 'lamp-lit t)
           "A bright light.")
          ((and (eq loc 'small-stable)
                (eq item 'door)
                have-matches)
           (table-set 'door-burned t)
           "It has turned to ashes.")
          ((eq item 'matches)
           "You lit them.")
          ((not (find-item item))
           "It doesn't burn")
          (t default))))

;; 2380
(defun fill-handler (loc item default)
  (cond ((and (find loc '(rough-water lake-middle))
              (find item '(bucket jug)))
         (table-set 'quest-failed t)
         "You capzised!")
        ((and (eq loc 'valley-stream)
              (eq item 'jug)
              (item-in-pocket item))
         (table-set 'jug-filled t)
         "It is now full.")
        ((and (eq loc 'valley-stream)
              (eq item 'bucket))
         "It leaks out!")
        (t default)))

;; 2420
(defun plant-handler (loc item default)
  (cond ((and (eq loc 'high-walled-garden)
              (eq item 'seeds))
         (table-set 'seeds-planted t)
         "OK.")
        (t "It does not grow")))

;; 2450
(defun water-handler (loc item default)
  (cond ((and (eq item 'seeds)
              (table-get 'seeds-planted)
              (table-get 'jug-filled))
         (table-set 'vine-grown t)
         "A large vine grows in seconds!")
        (t default)))

;; 2470
(defun swing-handler (loc item default)
  (cond ((and (eq loc 'cobwebby-room)
              (eq item 'sword))
         (table-set 'webs-cleared t)
         "You cleared the webs.")
        ((and (eq loc 'dank-corridor)
              (eq item 'axe))
         (set-location-exits 'dank-corridor '((n palace-entrance)
                                              (s palace-dungeons)))
         (set-location-exits 'palace-dungeons '((n dank-corridor)
                                                (s wine-cellar)))
         "The door broke!")
        ((and (eq loc 'well-bottom)
              (eq item 'axe))
         (set-location-exits loc '((n narrow-passage)))
         "You broke through!")
        ((find item '(axe sword))
         "THWACK!")
        (t default)))

;; 2520
(defun empty-handler (loc item default)
  (cond ((eq item 'jug)
         (water-handler loc 'seeds default))
        ((and (eq loc 'mosaic-hall)
              (eq item 'phial))
         "Where?")
        (t default)))

;; 2550
(defun enter-handler (loc item default)
  (cond ((and (eq loc 'outside-windmill)
              (eq item 'windmill))
         (go-handler loc 'e default))
        ((eq loc 'mountain-hut)
         (table-set 'planks nil)
         "You found something.")
        (t default)))

;; 2580
(defun cross-handler (loc item default)
  (cond ((eq loc 'west-bridge)
         (go-handler loc 'e default))
        ((eq loc 'east-bridge)
         (go-handler loc 'w default))
        (t default)))

;; 2610
(defun remove-handler (loc item default)
  (cond ((and (eq item 'boots)
              (table-get 'wearing-boots))
         (table-set 'wearing-boots nil)
         "Taken off.")
        ((and (eq item 'uniform)
              (table-get 'wearing-uniform))
         (table-set 'wearing-uniform nil)
         "OK.")
        ((find item '(bricks rubble))
         (move-handler loc item default))
        (t default)))

;; 2650
(defun feed-handler (loc item default)
  (cond ((or (and (eq loc 'wine-cellar)
                  (eq item 'rats))
             (and (eq loc 'barren-countryside)
                  (eq item 'boar))
             (and (eq loc 'rusty-gates)
                  (eq item 'pony))
             (and (eq loc 'overgrown-track)
                  (eq item 'pony))
             (and (eq loc 'glass-gates)
                  (eq item 'hound)))
         "With what?")
        (t default)))

;; 2670
(defun turn-handler (loc item default)
  (cond ((and (eq loc 'disused-waterwheel)
              (eq item 'wheel))
         "It goes round.")
        ((and (eq loc 'sluice-gates)
              (eq item 'handle))
         (table-set 'pool-empty t)
         "The gates open, the pool empties.")
        (t default)))

;; 2700
(defun dive-handler (loc item default)
  (cond ((find loc '(misty-pool lake-middle))
         (table-set 'quest-failed t)
         "You have drowned.")
        (t default)))

;; 2720
(defun bail-handler (loc item default)
  "How?")

;; 2730
(defun drop-handler (loc item default)
  (cond ((not (assoc item *items*))
         default)
        (t
         (set-item-location item loc)
         (cond ((and (or (eq loc 'rough-water)
                         (eq loc 'lake-middle))
                     (eq item 'boat))
                (table-set 'quest-failed t)
                "You drowned!")
               ((and (eq item 'jug)
                     (table-get 'jug-filled))
                (table-set 'jug-filled nil)
                "You lost the water!")
               (t
                ;; update also the sheet status
                (when (and (eq item 'boat)
                           (table-get 'using-sheet))
                  (table-set 'using-sheet nil)
                  (set-item-location 'sheet loc))
                (when (and (eq item 'sheet)
                           (table-get 'using-sheet))
                  (table-set 'using-sheet nil))
                "Done.")))))

;; 2800
(defun insert-handler (loc item default)
  (cond ((and (eq loc 'turret-room)
              (eq item 'coin)
              (item-in-pocket 'coins)
              (> (table-get 'money) 0))
         (format nil "A number appears - ~a" (table-get 'safe-code)))
        ((and (eq item 'coin)
              (= (table-get 'money) 0))
         "You do not have any.")
        (t
         default)))

;; 2830
(defun throw-handler (loc item default)
  (cond ((not (assoc item *items*))
         default)
        ((and (eq loc 'barren-countryside)
              (eq item 'net))
         (table-set 'boar-caught t)
         (set-item-location item loc)
         "You caught the boar.")
        (t
         (set-item-location item loc)
         "Did not go far!")))

;; 2870
(defun blow-handler (loc item default)
  (cond ((and (eq loc 'fallen-oak)
              (eq item 'reeds))
         (table-set 'ghost-freed t)
         (set-location-exits loc '((n scree-slope)
                                   (s dark-wood)))
         "The ghost of the goblin guardian is free!")
        ((eq item 'reeds)
         "A nice tune.")
        ((and (eq loc 'lake-edge)
              (eq item 'music))
         "What with?")
        ((eq item 'music)
         "How, o musical one?")
        (t default)))

;; 2920
(defun eat-handler (loc item default)
  (cond ((or (not (assoc item *items*))
             (not (item-in-pocket item)))
         default)
        ((find item '(apples bread))
         (set-item-location item nil)
         "Yum yum!")))

;; 2950
(defun move-handler (loc item default)
  (cond ((and (eq loc 'stalactites)
              (eq item 'rubble))
         (table-set 'rubble-moved t)
         "You revealed a steep passage.")
        ((and (eq loc 'hollow-tomb)
              (eq item 'rubble))
         "You cannot move rubble from here.")
        ((and (eq loc 'well-bottom)
              (eq item 'bricks))
         "They are wedged in.")
        (t
         default)))

;; 2990
(defun poison-handler (loc item default)
  (cond ((and (eq loc 'mosaic-hall)
              (or (eq item 'goblet)
                  (eq item 'wine))
              (item-in-pocket 'phial))
         (table-set 'wine-poisoned t)
         "OK.")
        (t
         default)))

;; 3010
(defun ring-handler (loc item default)
  (cond ((and (eq loc 'silver-bell)
              (eq item 'bell))
         (let ((times (parse-integer (input "How many times? "))))
           (cond ((equal times (table-get 'rings-needed))
                  (set-location-exits loc '((w perilous-path)
                                            (e palace-dungeons)))
                  "A rock door opens.")
                 (t
                  (table-set 'quest-failed t)
                  "You have mistreated the bell!"))))
        (t
         default)))

;; 3050
(defun cut-handler (loc item default)
  (if (and (eq loc 'cobwebby-room)
           (eq item 'cobwebs))
      (swing-handler loc 'sword default)
      default))

;; 3070
(defun show-handler (loc item default)
  (cond ((and (eq loc 'wizards-lair)
              (or (eq item 'up-silver-plate)
                  (eq item 'silver-plate))
              (item-in-pocket 'silver-plate))
         (table-set 'wizard-dead t)
         "You reflected the wizard's glare! He is dead.")
        ((eq item 'stone-of-destiny)
         (give-handler loc item default))
        (t default)))

;; 3100
(defun pay-handler (loc item default)
  (cond ((or (eq item 'coins) (eq item 'coin))
         (give-handler loc item default))
        ((and (eq item 'troll)
              (or (eq loc 'west-bridge)
                  (eq loc 'east-bridge)))
         "What with?")
        (t default)))

;; 3130
(defun unlock-handler (loc item default)
  (cond ((and (eq loc 'wizards-lair)
              (eq item 'door)
              (item-in-pocket 'key))
         (table-set 'door-unlocked t)
         "The key turns!")
        (t default)))

;; 3150
(defun break-handler (loc item default)
  (cond ((and (eq *current-location* 'dank-corridor)
              (eq item 'door))
         "How?")
        (t default)))

;; 3170
(defun reflect-handler (loc item default)
  (cond ((eq loc 'wizards-lair)
         "How?")
        (t default)))

;; 3190
(defun drink-handler (loc item default)
  "Are you thirsty?")

;; allowed commands
;;
;; meaning of the flags:
;;   :not-in-pocket command allowed if the item is not in pocket
;;   :wizard command allowed under the wizard's glare
(defparameter *allowed-commands*
  `(("n"          ,#'go-handler)
    ("e"          ,#'go-handler)
    ("s"          ,#'go-handler)
    ("w"          ,#'go-handler)
    ("u"          ,#'go-handler)
    ("d"          ,#'go-handler)
    ("inv"        ,#'inventory-handler)
    ("get"        ,#'get-handler :not-in-pocket)
    ("tak"        ,#'get-handler :not-in-pocket)
    ("ex"         ,#'examine-handler)
    ("exa"        ,#'examine-handler)
    ("examine"    ,#'examine-handler)
    ("read"       ,#'examine-handler)
    ("give"       ,#'give-handler)
    ("say"        ,#'say-handler)
    ("pick"       ,#'pick-handler :not-in-pocket)
    ("wear"       ,#'wear-handler)
    ("tie"        ,#'tie-handler)
    ("climb"      ,#'climb-handler :not-in-pocket)
    ("rig"        ,#'blow-handler)
    ("use"        ,#'use-handler :wizard)
    ("open"       ,#'open-handler)
    ("light"      ,#'burn-handler)
    ("fill"       ,#'fill-handler)
    ("plant"      ,#'plant-handler)
    ("water"      ,#'water-handler)
    ("swing"      ,#'swing-handler)
    ("empty"      ,#'empty-handler)
    ("enter"      ,#'enter-handler)
    ("cross"      ,#'cross-handler)
    ("remove"     ,#'remove-handler)
    ("feed"       ,#'feed-handler)
    ("turn"       ,#'turn-handler)
    ("dive"       ,#'dive-handler)
    ("bail"       ,#'bail-handler)
    ("leave"      ,#'drop-handler)
    ("throw"      ,#'throw-handler)
    ("insert"     ,#'insert-handler)
    ("blow"       ,#'blow-handler)
    ("drop"       ,#'drop-handler)
    ("eat"        ,#'eat-handler)
    ("move"       ,#'move-handler)
    ("intoxicate" ,#'poison-handler)
    ("ring"       ,#'ring-handler)
    ("cut"        ,#'cut-handler)
    ("hold"       ,#'show-handler :not-in-pocket :wizard)
    ("burn"       ,#'burn-handler)
    ("poison"     ,#'poison-handler)
    ("show"       ,#'show-handler :wizard)
    ("unlock"     ,#'unlock-handler)
    ("with"       ,#'use-handler :wizard)
    ("drink"      ,#'drink-handler)
    ("count"      ,#'examine-handler)
    ("pay"        ,#'pay-handler)
    ("make"       ,#'blow-handler)
    ("break"      ,#'break-handler)
    ("steal"      ,#'get-handler :not-in-pocket)
    ("gather"     ,#'get-handler :not-in-pocket)
    ("reflect"    ,#'reflect-handler :not-in-pocket :wizard)
    ;; special verbs
    ("save"       save)
    ("load"       load)
    ("exit"       exit)))

;; game functions
(defun game-init ()
  (setf *edges* (make-hash-table))
  (setf *item-locations* (make-hash-table))
  (setf *table* (make-hash-table))

  ;; set the edges of each room
  (mapc (lambda (locpair)
          (let* ((id (car locpair))
                 (exits (cddr locpair)))
            (setf (gethash id *edges*) exits)))
        *nodes*)

  ;; set the locations of the items
  ;; and the visible items
  (mapc (lambda (item)
          (let ((id (car item))
                (location (cadddr item))
                (flags (cddddr item)))
            (setf (gethash id *item-locations*) location)
            (when (find :hidden flags)
              (table-set id t))))
        *items*)

  ;; set some generic variables
  (table-set 'boots-time 0)
  (table-set 'water-time 0)
  (table-set 'money 4)
  (table-set 'third-word (random 3))
  (table-set 'safe-code (+ 100 (random 900)))
  (table-set 'rings-needed (+ 2 (random 3)))
  ;; set the initial location
  (setf *current-location* 'crossroads)
  ;; set the directions to exit the tunnels
  (setf *tunnel-forward* (loop repeat 8 for d = (nth (random 4) '(n s e w)) collect d))
  (setf *tunnel-backward* (mapcar (lambda (d)
                                     (cond ((eq d 'n) 's)
                                           ((eq d 's) 'n)
                                           ((eq d 'w) 'e)
                                           ((eq d 'e) 'w)
                                           (t d)))
                                  (reverse *tunnel-forward*)))
  nil)

(defun game-save (filename)
  (flet ((hash-to-alist (hash)
           (let ((alist nil))
             (maphash (lambda (key value)
                        (setf alist (acons key value alist)))
                      hash)
             alist)))
    (handler-case
        (with-open-file (out filename :direction :output :if-exists :supersede)
          (let ((alist `((edges ,@(hash-to-alist *edges*))
                         (item-locations ,@(hash-to-alist *item-locations*))
                         (table ,@(hash-to-alist *table*))
                         (current-location . ,*current-location*)
                         (tunnel-forward . ,*tunnel-forward*)
                         (tunnel-backward . ,*tunnel-backward*))))
            (write alist :stream out))
          t)
      (error (c)
        nil))))

(defun game-load (filename)
  (flet ((alist-to-hash (alist)
           (let ((hash (make-hash-table)))
             (mapc (lambda (keyval)
                     (setf (gethash (car keyval) hash)
                           (cdr keyval)))
                   alist)
             hash)))
    (handler-case
        (with-open-file (in filename :direction :input)
          (let ((alist (read in)))
            (setf *edges* (alist-to-hash (cdr (assoc 'edges alist))))
            (setf *item-locations* (alist-to-hash (cdr (assoc 'item-locations alist))))
            (setf *table* (alist-to-hash (cdr (assoc 'table alist))))
            (setf *current-location* (cdr (assoc 'current-location alist)))
            (setf *tunnel-forward* (cdr (assoc 'tunnel-forward alist)))
            (setf *tunnel-backward* (cdr (assoc 'tunnel-backward alist))))
          t)
      (error (c)
        nil))))

(defun describe-location (loc)
  (format nil "You are ~a." (location-name loc)))

(defun describe-items (loc)
  (let ((items (mapcar #'item-name
                       (remove-if (lambda (item)
                                    (or (not (eq (item-location item) loc))
                                        (item-hidden item)))
                                  (remove 'apple (mapcar #'car *items*))))))

    ;; add some custom descriptions
    (let ((items (cond ((and (eq loc 'banqueting-hall)
                             (table-get 'grarg-sleeping))
                        (cons "a sleeping grarg" items))
                       ((eq loc 'banqueting-hall)
                        (cons "grargs feasting" items))
                       ((or (eq loc 'rusty-gates)
                            (eq loc 'overgrown-track))
                        (cons "a pony" items))
                       ((eq loc 'valley)
                        (cons "a hermit" items))
                       ((and (eq loc 'dank-corridor)
                             (not (can-go loc 's)))
                        (cons "an oak door" items))
                       ((and (eq loc 'ogbans-chamber)
                             (table-get 'ogban-dead))
                        (cons "Ogban (dead)" items))
                       (t items))))
      (and items (format nil "You can see ~{~a~^, ~}." items)))))

(defun describe-paths (loc)
  (let ((exits (mapcar #'car (location-exits loc))))
    (and exits (format nil "You can go ~(~{~a~^, ~}~)." exits))))

(defun look-at (loc response)
  (format nil "~@{~@[~a~^ ~]~}"
          response
          (describe-location loc)
          (describe-items loc)
          (describe-paths loc)))

(defun princ-within-columns (string columns)
  (let ((string-length (length string)))
    (labels ((line-loop (i column space-pos printed-pos)
               (cond ((= i string-length)
                      (fresh-line)
                      (princ (subseq string printed-pos string-length)))
                     ((eq (char string i) #\Space)
                      (cond ((>= (1- column) columns)
                             (fresh-line)
                             (princ (subseq string printed-pos space-pos))
                             (line-loop (1+ i) (- i space-pos) i (1+ space-pos)))
                            (t
                             (line-loop (1+ i) (1+ column) i printed-pos))))
                     (t
                      (line-loop (1+ i) (1+ column) space-pos printed-pos)))))
      (line-loop 0 0 0 0))))

(defun game-loop (&optional (response "Good luck on your quest!"))
  (princ "[2J[H")
  (format t "~40:@<~a~>~%" "Mystery of Silver")
  (format t "~40:@<~a~>~%" "Mountain")
  (princ "========================================")
  (terpri)
  (terpri)
  (cond ((table-get 'quest-won)
         (princ "HOOOOORRRRRRAAAAAYYYYYY!") (terpri)
         (terpri)
         (princ "You have succeeded in your") (terpri)
         (princ "quest and brought peace to") (terpri)
         (princ "land!")
         (terpri))
        ((table-get 'quest-failed)
         (princ-within-columns response 40)
         (terpri)
         (princ "You failed your quest!")
         (terpri))
        (t
         (princ-within-columns (look-at *current-location* response) 40)
         (terpri)
         (terpri)
         (princ "========================================")
         (terpri)
         (terpri)
         (let* ((string (input "What will you do? "))
                (len (length string))
                (ws (position #\Space string))
                (verb (subseq string 0 (or ws len)))
                (target (subseq string (if ws (1+ ws) len)))
                (handler (assoc verb *allowed-commands* :test #'string=))
                (fun (cadr handler))
                (flags (cddr handler))
                (item (cond ((eq fun #'go-handler)
                             (cond ((string= verb "n") 'n)
                                   ((string= verb "s") 's)
                                   ((string= verb "w") 'w)
                                   ((string= verb "e") 'e)
                                   ((string= verb "u") 'u)
                                   ((string= verb "d") 'd)
                                   (t nil)))
                            ((string= target "") nil)
                            (t
                             (or (find-item target)
                                 (find-item (concatenate 'string target "s")))))))
           (cond ((eq fun 'exit)
                  (princ "Bye..."))
                 ((eq fun 'save)
                  (princ "Saving...")
                  (fresh-line)
                  (let ((filename (input "Plase enter the filename: ")))
                    (game-loop (if (game-save filename)
                                   "OK, carry on."
                                   "I could not save the file."))))
                 ((eq fun 'load)
                  (princ "Loading...")
                  (fresh-line)
                  (let ((filename (input "Please enter the filename: ")))
                    (game-loop (if (game-load filename)
                                   "OK, carry on."
                                   "I could not load the file."))))
                 ((string= string "")
                  (game-loop "Try something else."))
                 ((and (not handler) (not item))
                  (game-loop (format nil "You cannot ~a." string)))
                 ((not handler)
                  (game-loop "Try something else."))
                 (t
                  (let ((message (if item "Pardon?" "I need two words.")))
                    (cond ((and (not (find :not-in-pocket flags))
                                (assoc item *items*)
                                (not (item-in-pocket item)))
                           (game-loop (format nil "You do not have the ~a." target)))
                          ((and (eq *current-location* 'wizards-lair)
                                (not (table-get 'wizard-dead))
                                (not (find :wizard flags)))
                           (game-loop "The wizard has you in his glare."))
                          (t
                           (game-loop (funcall fun *current-location* item message)))))))))))

(defun game-start ()
  (game-init)
  (game-loop))
