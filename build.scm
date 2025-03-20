#!/run/current-system/sw/bin/guile \
--no-auto-compile -s
!#

(use-modules (ice-9 popen)
             (ice-9 rdelim)
             (ice-9 format))

(define (run-command cmd)
  (display (string-append "Running: " cmd "\n"))
  (let* ((proc (open-pipe* OPEN_READ "sh" "-c" cmd))
         (output (read-line proc)))
    (close-pipe proc)
    output))

(define (compile files)
  (for-each (lambda (file) (run-command (string-append "ocamlc -c " file))) files))

(define (clean)
  (run-command "rm -f *.cmi *.cmo fthi"))

(define (build)
  (clean)
  (compile '("state.mli" "state.ml" "eval.mli" "eval.ml" "main.ml"))
  (run-command "ocamlc -o fthi state.cmo eval.cmo main.cmo"))

(build)
(display "Build finished. Run ./fthi\n")
