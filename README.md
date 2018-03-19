# Project outline
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