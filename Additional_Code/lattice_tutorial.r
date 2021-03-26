#######################################
########## lattice Tutorial ###########
#######################################

#	install.packages("Ecdat")


library(lattice)
library(MASS) 
library(fpp)
library(Ecdat)

###########################
########## Basics #########

# Das typische Format fuer die Erstellung eines lattice plots ist: 
# graphen_typ(formula, data =). Fuer graph_type muss die jeweils gewuenschte 
# Funktion aus dem lattice Paket gewaehlt werden. Fuer manche Funktionen kann 
# allerdings ein Plot mit der Form graphen_typ(data) und graphen_typ(formula, data =)  
# erstellt werden.


## Beispiel ##

xyplot(lat~long, data=quakes, pch=1)

## Gleicher Plot ##
tplot <- xyplot(lat~long, data=quakes, pch=1)
print(tplot)

# Anmerkung: Die lattice Funktionen erstellen ein Objekt der Klasse "trellis". 
# Diese wird nur aufgerfen wenn die Funktion direkt aufgerufen wird. 
# Falls allerdings die Funktion in einer Schleife aufgerufen wird, 
# ist kein Plot zu sehen.


## Alle Funktionen koennen nachtraeglich ergaenzt werden ##

tplot2 <- update(tplot,
               main="Earthquakes in the Pacific Ocean (since 1964)")
print(tplot2)


## Beispiel ohne die Verwendung von formula ##
# xyplot enthaelt eine Methode fuer Objekte des Typs ts. 
# Diese werden automatisch erkannt und abgebildet.

xyplot(a10, main="Ueberschrift")
xyplot(a10, main="Ueberschrift", type=c("l","g"))
xyplot(a10, main="Ueberschrift", type=c("p","g"))

############################################################
### Beispiele, die mit Formeln erstellt werden.  ###########

# y ~ x                 Plot mit y gegen x.
# y1 + y2 ~ x 	        Plot mit y gegen x, allerdings werden y1 und y2 duch
#                       unterschiedliche Farben, Symbole etc.deutlich gekennzeichnet 
#                       und beide y-Variablen werden auf einer Achse abgebildet.
# y ~ x1 + x2 	        Es wird ein Plot mit y gegen x1 erstellt. 
#                       Zusaetzlich erfolgt im selben Plot die Abbildung 
#                       von y und x2.
# z ~ x1*x2 	          Es wird ein dreidimensionaler Plot erstellt. 
#                       Jede Variable wird mit einer eigenen Achse abgebildet.
# y ~ x | A*B           Es werden mehrere Plots fuer alle Kombinationsmoeglichkeiten 
#                       der Varaibalen A und B erstellt. A und B werden wie Faktoren 
#                       behandelt.
# y ~ x | B, groups=A   Es werden mehrere Plots in Abhängigkeit von B und A erstellt. 


############################################
### Funktion fuer den gewuenschten Plot. ###

# graph_type      Beschreibung          Beispiel
#
#  barchart 	     bar chart 	          x~A or A~x
#  bwplot 	       boxplot 	            x~A or A~x
#  cloud 	         3D scatterplot 	    z~x*y|A
#  contourplot 	   3D contour plot 	    z~x*y
#  densityplot 	   kernal density plot 	~x|A*B
#  dotplot 	       dotplot 	            ~x|A
#  histogram 	     histogram          	~x
#  levelplot 	     3D level plot 	      z~y*x
#  stripplot 	     strip plots 	        A~x or x~A
#  xyplot 	       scatterplot 	        y~x|A
#  wireframe 	     3D wireframe graph 	~y*x

# Anmerkung: Ein großer Buchstabe ist eine Variable, der als Faktor behandelt
# wird.

#####################################
###  Beispiele der Plots ############
#####################################

##############################
########## barchart  #########

# barchart mit formula
mtcars$cars <- rownames(mtcars)
barchart(cars ~ mpg, data=mtcars, scales=list(cex=0.7), main="Cars versus MPG")

# barchart ohne formula 
msft <- c(26.85, 27.41, 28.21, 32.64, 34.66, 34.30, 31.62, 33.40)
msft.returns<- msft[-1] / msft[-length(msft)] -1
names(msft.returns) <- month.abb[1:length(msft.returns)]  
barchart(msft.returns, main="MSFT Returns",xlab="Return",origin=0)

# barchart mit Gruppierung
barchart(Claims/Holders ~ Age | Group, groups=District,
         data=Insurance, origin=0, auto.key=T)

# barchart mit Gruppierung und angepasster Legende
barchart(Claims/Holders ~ Age | Group, groups=District,
         data=Insurance, main="Claims frequency", 
         auto.key=list(space="top", columns=4, 
                       title="District", cex.title=1))

# barchart mit Gruppierung
barchart(yield ~ variety | site, data = barley,
         groups = year, layout = c(1,6),
         ylab = "Barley Yield (bushels/acre)",
         scales = list(x = list(abbreviate = TRUE,
                                minlength = 5)))


# barchart mit Gruppierung und angepasster Legende
barchart(yield ~ variety | site, data = barley,
         groups = year, layout = c(1,6), stack = TRUE, 
         auto.key = list(points = FALSE, rectangles = TRUE, space = "right"),
         ylab = "Barley Yield (bushels/acre)",
         scales = list(x = list(rot = 45)))


##############################
########## bwplot ############
bwplot(mpg~disp, data= mtcars)

bwplot(voice.part ~ height, data=singer, xlab="Height (inches)")


###############################
########## dotplot ############

dotplot(mpg~disp, data= mtcars)

dotplot(variety ~ yield | year * site, data=barley)


dotplot(variety ~ yield | site, data = barley, groups = year,
        key = simpleKey(levels(barley$year), space = "right"),
        xlab = "Barley Yield (bushels/acre) ",
        aspect=0.5, layout = c(1,6), ylab=NULL)


#################################
########## histogram ############


histogram( ~ height | voice.part, data = singer,
           xlab = "Height (inches)", type = "density")


#########################################
######## kernel density plot ############
densityplot(~mpg, data=mtcars,
            main="Density Plot",
            xlab="Miles per Gallon")



# kernel density Plots fuer jede Zylinderart
densityplot(~mpg|cyl, data=mtcars,
            main="Density Plot by Number of Cylinders",
            xlab="Miles per Gallon")


##########################################
########## scatterplot matrix ############
splom(mtcars[c(1,3,4,5,6)],
      main="MTCARS Data")



######################################
########## 3D Scatterplot ############

attach(mtcars)
gear.f<-factor(gear,levels=c(3,4,5),
               labels=c("3gears","4gears","5gears"))
cyl.f <-factor(cyl,levels=c(4,6,8),
               labels=c("4cyl","6cyl","8cyl")) 


cloud(mpg~wt*qsec|cyl.f,
      main="3D Scatterplot by Cylinders") 



########################################
########## 3D wireframeplot ############
wireframe(volcano, shade = T,
          aspect = c(61/87, 0.3),
          light.source = c(10,10,10))



########################################
### Anpassung der Plots  ###############
########################################

# Jede Funktion hat einige Parameter, mit denen die globalen Einstellungen des 
# jeweiligen Plottyps veraendert werden koennen. Allerdings ist jede Funktion 
# nur ein Wrapper fuer eine weitere Funktion, die die eigentliche Abbildung 
# vornimmt und als Panel-Funktion bezeichnet wird. 
# Jede Plot-Funktion besitzt daher eine eigene Panel-Funktion, die wiederum 
# spezifische Parameter, besitzt. Um diese Parameter anzusprechen, muessen 
# diese in der Wrapper-Funktion angegeben werden. Die Argumente werden 
# autmatisch an die Panel-Funktion weitergegeben. 
# Jede Panel-Funktion ist eigenstaendig dokumentiert. Anpassungen der Plots
# erfolgen ueber die Panel-Funktionen.

# Jeder Wrapper besitzt mindestens eine Panel-Funktion. Zusaetzlich sind weitere
# Panel-Funktionen zur Erweiterung verfuegbar.

# panel.abline()        add a line from a to b, also fit line from lm object
# panel.refling() 	    add a reference line
# panel.rug() 	        add a rug to a densityplot
# panel.curve() 	      add a curve based on an expression
# panel.average() 	    add a mark for average (e.g., to box & whiskers plot or interaction plot)
# panel.grid() 	        add a reference grid
# panel.lmline() 	      add a regression line; equivalen to panel.abline(lm(y~x))
# panel.loess() 	      add a loess smoothed line
# panel.mathdensity() 	add a (usually theoretical) probability density function
# panel.arrows() 	      add arrows
# panel.axis() 	        manually add an axis (called by default in most high-level functions)
# panel.brush.splom() 	panel function to allow interaction wtih lattice plots
# panel.identify() 	    panel function to allow interaction wtih lattice plots
# panel.link.splom() 	  panel function to allow interaction wtih lattice plots
# panel.lines() 	      add lines; equivalent to llines()
# panel.points() 	      add points; equivalnet to lpoints()
# panel.polygon() 	    add a polygon; equivalent to lpolygon()
# panel.rect() 	        add a rectangle; equivalent to lrect()
# panel.segments() 	    low level line segments


### Beispiel einer optischen Veränderung:
# Die Parameter lwd und col.line sind in der Dokumentation von 
# xyplot (Wrapper) nicht enthalten, da sie zu der zugehörigen Panel-Funktion 
# panel.xyplot() gehoeren. Es ist daher notwendig die Dokumentation der 
# Wrapper-Funktion und der enthaltenen Panel-Funktionen zu betrachten.
xyplot(y~ x, data,
       grid = TRUE,
       scales = list(x = list(log = 10, equispaced.log = FALSE)),
       type = c("p", "smooth"), col.line = "darkorange", lwd = 3)


### Beispiel zur Anpassung eines Histogramms 
# Anpassungen von Plots können auch durch die Verwendung von anderen und/ oder 
# umgaenderten Panel-Funktionen erfolgen. 

# Einfaches Histogramm 
histogram( ~ height | voice.part, data = singer,
           xlab = "Height (inches)", type = "density")

# Hinzufügen der Dichtefunktion 
# Die bestehende Panel-Funktion wird ueberschrieben,
# indem die eigentliche Panel-Funktion (panel.histogram) und eine weiere 
# Panel-Funktion (panel.mathdensity) eingefuegt wird.
histogram( ~ height | voice.part, data = singer,
           xlab = "Height (inches)", type = "density",
           panel = function(x, ...) {
             panel.histogram(x, ...)
             panel.mathdensity(dmath = dnorm, col = "black",
                               args = list(mean=mean(x),sd=sd(x)))
           } )

# Die eigentliche Panel-Funktion, die in histogram() enthalten ist kann auch 
# entfernt werden und ersetzt werden. Dadurch wird nur noch panel.mathdensity 
# grafisch abgebildet.
histogram( ~ height | voice.part, data = singer,
           xlab = "Height (inches)", type = "density",
           panel = function(x, ...) {
             #panel.histogram(x, ...)
             panel.mathdensity(dmath = dnorm, col = "black",
                               args = list(mean=mean(x),sd=sd(x)))
           } )








