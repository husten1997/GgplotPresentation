#############################################################
########## ggplot2/lattice/graphics/ - Vergleich  ###########
#############################################################

##################################################
######## Vergeleich graphics und lattice #########

library(AER)

data(CPS1985)

# Beide Packages ähneln sich in ihrere Funktionsweise. Vor allem die Anwendung
# von lattice-Funktionen mit Hilfe von Formeln ist fast identisch zu graphics::
# plot-Funktion. Allerdings ist die Darstellung von mehreren Plots in Abhaengig-
# keit einer Gruppe mit den einzelnen Funktionen des Packages graphics nicht 
# im gleichen Umfang moeglich. 

# Beispiel:
# Eine Abbildung einzelner Variablen ist nur mittels einer Scatterplotmatrix 
# moeglich.
plot(CPS1985) 

# Lattice ermoeglicht Vergleiche, die mit graphics nicht moeglich sind.
# Beispiel:
mtcars$cars <- rownames(mtcars)
barchart(Claims ~ Age | Group, groups=District,
         data=Insurance, main="Claims frequency", 
         auto.key=list(space="top", columns=4, 
                       title="District", cex.title=1))


# Lattice beinhaltet hingegen keine generische Funktion, wie sie in graphics::plot()
# vorhanden ist.
# Beispiel:
# factor wird erkannt:
plot(CPS1985[,5])

# numeric wird erkannt:
plot(CPS1985[,1])

# In lattice muss die passende Funktion ausgewaehlt werden:
xyplot(CPS1985[,1] ~ seq_along(CPS1985[,1]), xlab = "Index") 


# Zeitreihen koennen jedoch von beiden packages abgebildet werden
plot(a10)
xyplot(a10)

# Mit Hilfe der Panel-Funktionen koennen lattice Plots deutlich umfangreicher 
# angepasst und veraendert werden. Das Package graphics bietet deutlich weniger 
# Parameter fuer Anpassungsmoeglichkeiten.
histogram( ~ mpg| gear, data = mtcars,
           xlab = "Height (inches)", type = "density",
           panel = function(x, ...) {
             panel.histogram(x, ...)
             panel.mathdensity(dmath = dnorm, col = "black",
                               args = list(mean=mean(x),sd=sd(x)))
           } )



attach(mtcars)
par(mfrow=c(3,1))
hist(mpg[gear==5],  col="red", xlab="Miles Per Gallon", freq=F, 
        main="Histogram with Normal Curve")
lines(density(mpg[gear==5])) 


hist(mpg[gear==3],  col="red", xlab="Miles Per Gallon", freq=F, 
     main="Histogram with Normal Curve")
lines(density(mpg[gear==5])) 


hist(mpg[gear==4],  col="red", xlab="Miles Per Gallon", freq=F, 
     main="Histogram with Normal Curve")
lines(density(mpg[gear==5])) 

## Fazit: ##
# Die einzelnen Funktionen des graphics-Package eigenen sich vorallem um 
# schnell einen Ueberblick ueber einen Datensatz zu bekommen. Falls der Plot 
# nicht unbedingt anderen Personen zur Verfuegung gestellt werden soll, ist die 
# einfache Darstellung oftmals vollkommen ausreichend. Eine umfassende optische 
# Anpassung ist durch das lattice-Package möglich, das eine Fuelle an Moeglich-
# keiten anbietet. Allerdings ist die Erstellung auch deutlich komplexer. Daher 
# ist festzuhalten, dass die Funktionen in graphics alles Notwendige anbieten,
# um einfache Plots jeder Art zu erstellen. Einen hoeren Anspruch an die Dar-
# stellung ist mit lattice zu ermoeglichen.

################################################
######## Vergeleich ggplot und lattice #########

## Geschwindigkeit ##
# Beide Packages basieren auf dem Package grid. 
# Bei einfachen Grpahen ist kein Unterschied bezüglich der Geschwindkeit
# ersichtlich, allerdings wird der Geschwindigkeitsvorteil von lattice
# bei sehr großen Datensaetzen und bei der Generierung vieler Graphen ersichtlich.

## Gestaltungsmoeglichkeiten ##
# Lattice bietet mehr Moeglichkeiten einen Plot zu veraendern und an die 
# gewuenschte Erscheinung anzupassen.Vorallem in den Details laesst lattice mehr
# Spielraum zu. ggplot bietet jedoch mehr Moeglichkeiten in der Positionierung 
# einzelner Elemente, wie z.B. die Position einer Legende.

## Syntax ##
# Die Syntax von lattice ist deutlich komplexer, was vor allem an den Parametern 
# der einzelnen Funktionen und den dazugehoerigen Panel-Funktionen liegt. ggplot 
# ist diesbezueglich einfacher zu verstehen, zu gestalten und nachzuvollziehen. 
# Einzelne Funktionen von ggplot bieten Gestaltungsmoeglichkeiten, die in lattice
# nur duch eine vielzahl an Parameter in den Funktionen und den dazugehoerigen 
# Panel-Funktionen realisierbar sind.

## Dokumentation ## 
# Die Moeglichkeiten von ggplot sind aussfuehrlich dokumentiert. Zusaetzlich 
# finden sich im Netz viele Beispiele und Anwendungsmoeglichkeiten. lattice ist 
# hingegen nicht so ausfuehrlich dokumentiert. AUfgrund der geringeren
# Verbreitung finden sich auch weniger Beispiele und Hilfestellungen auf Seiten 
# wie z.B. stackoverflow. 


## Fazit ## 
# ggplot bietet einen besseren Kompromiss zwischen Anwendungsmoeglichkeit und 
# Lernaufwand. Der Vorteil von ggplot ist die ausfuehrliche Dokumentation und 
# die Nachvollziebarbarkeit, wenn mann die Gestaltung mittels dem  Layer-Prinzip 
# begriffen hat. Fuer einfache Plots ist lattice ebenfalls sehr gut geeignet, 
# da es fast fuer jeden Plot-Typ eine eigene Funktion gibt. Allerdings ist die 
# Anpassung und Variation eines Plots deutlich schwieriger vorzunehmen. Fuer 
# einfache Plots ohne große Aenderungen eignet sich lattice aufgrund der vielen 
# Funktionen hervorragend. Spezifisch angepasste Plots sind mit ggplot besser zu
# realisieren. Fuer stark angepasste und aufwendige Plots ist lattice besser 
# geeignet aber auch schwieriger umzusetzen.

################################################################################

# Im Großen und Ganzen ist festzuhalten, dass die Funktionen des graphics-Package 
# und dabei vor allem plot(), für einfache Darstellungen sehr gut geeignet ist.
# Während ggplot2 und lattice anspruchsvollere Darstellungen ermöglichen. 
# Die Dokumentation von ggplot2 ist deutlich besser und dessen Funktionen sind 
# übersichtlicher gestaltet, sodass diese einfacher nachvollziehen werden können
# als die von lattice. 