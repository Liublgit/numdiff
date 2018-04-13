### Tasks
* Sivert: Find regularity-result Poisson equation. Rewrite introduction/definition ellipticy.
* Need to do some changes in ninepoint. Now it is taking in N and M as arguments, but they
  are set equal inside the function. Need to either take in only N or M, or changee something inside the function.
* Maybe we should make a table where we compare the error of fivepoint and ninepoint for different choices of M=N.

### Analysis (10 p.)
* Motivate your choice of method
* Provide an analysis of the problem justifying the choice of the discretization
* Prove the convergence of the numerical scheme (at least for a simplified, but relevant test problem)
 
### Applications (relevant reading before reporting in latex)
* https://en.wikipedia.org/wiki/Plate_theory 
* https://en.wikipedia.org/wiki/Stokes_flow
* https://en.wikiversity.org/wiki/Airy_stress_function

### Helpful articles
* http://www.maths.dundee.ac.uk/plin/ChenLiLin.pdf (similar problem and approach)
* https://ocw.mit.edu/courses/aeronautics-and-astronautics/16-920j-numerical-methods-for-partial-differential-equations-sma-5212-spring-2003/lecture-notes/lec4.pdf (discretization of elliptic eq./Poisson, slides from MIT)
* https://l.facebook.com/l.php?u=http%3A%2F%2Fwww2.math.umd.edu%2F~dlevy%2Fclasses%2Famsc466%2Flecture-notes%2Fdifferentiation-chap.pdf&h=ATPUdh4w4-fLDpAtFnk88cBR73-tAgXhFPAEe_4pkyqqDKYwp21QLzSKMq59P81lsHB6ejmj8uj0jRec75EuRJad0e94XTMk1rgDIosjxsgj3VhAeGVSJrBFE8k8ZNrKnlM enkelt skrevet taylorutvikling
* http://brunoc69.xtreemhost.com/courses/WS05-06/numerikII/stencil.pdf?i=2 Nine-point (skewed) stencil
* http://math.oregonstate.edu/~restrepo/475B/Notes/sourcehtml/node51.html (5-point formula)
* http://math.oregonstate.edu/~restrepo/475B/Notes/sourcehtml/node52.html (9-point formula)
* http://math.unice.fr/~nkonga/Cours/FDFV/MaxPandStab.pdf Discrete maximum principle anvendt på test-problem med fremgangsmåte, muligens nyttig
* https://books.google.no/books?id=M0tkw4oUucoC&pg=PA162 Derivation of modified nine-point method
* https://services.math.duke.edu/~leili/teaching/duke/math660s16/lectures/lec3.pdf Analyse av finite difference-metoder

### Pep-talk from Charles
Charles gikk raskt gjennom noen punkter som kan være greie å ha som utgangspunkt.
1. What am I solving?
    * i.e. find appropriate boundary conditions
    * Find out what the equation represents
1. Try and "classify" the PDE
    * Time dependent or not?
    * Is it hyperbolic/parabolic/elliptic? Is it a particular class, e.g. conservation law?
    * Most equations are
        1. Hyperbolic conservation law (Lax-Wendroff?)
        1. Possibly non-linear diffusion (Crank-Nicholson?)
        1. Assorted elliptic problems (Discretizations in space with 5 point method?)
1. Given the rough behaviour, what method would you try?
    * What difficulties does the equation bring? (e.g. non-linearity makes implicit scheme more difficult)
    * Suggestions for different schemes above
1. Try and google for some methods
1. Implement!
1. Analysis aspect
    * Charles will cover what is expected on Friday
