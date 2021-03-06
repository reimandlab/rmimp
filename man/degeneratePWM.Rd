% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pwm-functions.r
\name{degeneratePWM}
\alias{degeneratePWM}
\title{Create a degenerate PWM
i.e. for each aa group, set weight to the best weight of the group at that position
e.g. R-2 has weight 0.7, K-2 has weight 0.1. Set both R-2 and K-2 to 0.7}
\usage{
degeneratePWM(pwm, dgroups = c("DE", "KR", "ILMV", "QN", "ST"))
}
\arguments{
\item{pwm}{position weight matrix}

\item{dgroups}{groups of amino acids}
}
\description{
Create a degenerate PWM
i.e. for each aa group, set weight to the best weight of the group at that position
e.g. R-2 has weight 0.7, K-2 has weight 0.1. Set both R-2 and K-2 to 0.7
}
\keyword{internal}
