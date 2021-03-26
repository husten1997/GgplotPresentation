######################################
########## ggplot 2 Tutorial #########
######################################

#	install.packages("ggplot2")
#	install.packages("ggfortify")
#	install.packages("fpp")
#	install.packages("forecast")
#	install.packages("vars")

library(ggplot2)
library(ggfortify)
library(fpp)
library(forecast)
library(vars)

###########################
########## Basics #########

# Das Herz einer ggplot2 Graphik stellt der Datensatz dar, der die Form eines data
# frames besitzt. Daher muss zu Anfang der Datensatz bestimmt werden und in Folge 
# werden grafische Objekte (geoms und stats) hinzugefuegt. ggplot basiert auf 
# verschiedenen Layers, d.h. es muss zunaechst ein Rahmen der Graphik durch die 
# Funktion ggplot() festgelegt werden. Mit "+" werden im Anschluss grafische 
# Elemente bzw. Layer hinzugefuegt.

# Es wird nun beispielhaft ein Datensatz erstellt und der Funktion ggplot() 
# uebergeben. Mit aes() (= Aestehtics) wird angegeben welche Komponenten des 
# Datensatzes in der Graphik abgebildet werden. Aesthetics sind zudem Zuweisungen, 
# die beschreiben, wie Variablen auf visuelle Merkmale abgebildet werden sollen. 
# Das heißt, die Aesthetics bestimmen die Gestalt der geoms. Dazu werden Eigen-
# schaften benutzt, wie zum Beispiel Farbe, Form, Größe, Transparenz usw. Jedes 
# geom kann aber nur eine begrenzte Anzahl von aesthetics abbilden. Allerdings ist 
# im unteren Beispiel kein grafisches Objekt definiert, sodass die Warnmeldung 
# "Error: No layers in plot" erscheint.

dat <- data.frame(cond = rep(c("A", "B"), each=10),
                  xvar = 1:20 + rnorm(20,sd=3),
                  yvar = 1:20 + rnorm(20,sd=3))

ggplot(dat, aes(x=xvar, y=yvar))

# Es muss also festgelegt werden, wie die Elemente optisch abgebildet werden
# sollen. Dies erfolgt mit den sogenannten geoms, die mit einem "+" hinzugefuegt
# werden und somit ein Layer der Graphik hinzugefuegt wird.

ggplot(dat, aes(x=xvar, y=yvar)) + geom_line()

# Alternative Darstellung:
graph <- ggplot(dat, aes(x=xvar, y=yvar)) 
graph + geom_line()
graph + geom_point()

###########################
########## Geoms  #########

# Geoms sind die Formelemente, die die Daten in der Graphik darstellen. Sie koennen
# in 2 Kategorien eingeteilt werden. Die darstellenden geoms und die 
# funktionsbasierenden geoms. geom_line() oder geom_point() sind dem ersteren 
# zuzuordnen, während bspw. geom_boxplot() zweiterem zugeordnet wird. ggplot 
# bildet hierbei automatisch Kategorien.

#############
# Boxplot:
ggplot(dat, aes(factor(cond),  y = yvar))+ geom_boxplot()


###################
# Density Function:
ggplot(dat, aes(x = xvar)) + geom_density()

ggplot(dat, aes(x=xvar)) + geom_histogram(binwidth=3)

ggplot(dat, aes(x=xvar)) +
  geom_histogram(binwidth=3, colour="black", fill="white")


########### 
# Bar-Plot:
# Die Default Einstellung von geom_bar() ist stat='bin'. Dadurch werden die 
# Haeufigkeit der angegebenen Faktoren dargestellt.
ggplot(dat, aes(factor(cond))) +
  geom_bar()

# Falls eine metrische Variable vorhanden ist, muss stat='identity' angegeben 
# werden. In diesem Fall wird die Summe der Variable y fuer die jeweilige Gruppe
# A und B angezeigt.
ggplot(dat, aes(factor(cond) ,  y = yvar)) +
  geom_bar(stat = "identity")

# Der Plot kann mit coord_flip gedreht werden
ggplot(dat, aes(factor(cond) ,  y = yvar)) +
  geom_bar(stat = "identity") +
  coord_flip()


###################
# Farbe hinzufuegen:
# Falls die Fuellung in Abhaengigkeit des Faktors erfolgen soll, muss dies 
# bei den Aesthetics angegeben werden. Es wird automatisch eine Legende erstellt.
ggplot(dat, aes(factor(cond) ,  y = yvar, fill=cond)) +
  geom_bar(stat = "identity")

# Die Verwendung einer eigenen Farbauswahl wird durch scale_fill_manual() 
# ermoeglicht. 
ggplot(dat, aes(factor(cond) ,  y = yvar, fill=cond)) +
  geom_bar(stat = "identity" ) +  
  scale_fill_manual(values=c("#199799", "#A11F00"))


#########################################
# Regressionsgerade mit Konfidenzbereich:
# Generell koennen beliebige geoms in die Graphik hinzugefuegt werden. 
ggplot(dat, aes(x=xvar, y=yvar)) +  
  geom_point(shape=1) + 
  geom_smooth(method=lm,   se=T) +
  ggtitle("Titel des Plots")

# Zur Uebersicht kann das Argument group der aes()-Funktion hinzugezogen werden
# Es bestimmt welche Observation in der Grafik ausgefuehrt werden soll.
ggplot(dat, aes(x=xvar, y=yvar, group = cond)) +  
  geom_point(shape=1) + 
  geom_smooth(method=lm,   se=T) +
  ggtitle("Titel des Plots")

# Beispiel fuer eine Beschriftung der abgebildeten Punkte.
ggplot(dat, aes(x=xvar, y=yvar, label=cond)) +
  geom_point(shape=1) +
  geom_smooth(method=lm,se=T)+
  geom_text()+
  ggtitle("Titel des Plots")+
  labs(x = "Beschriftung X-Achse")+
  labs(y = "Beschriftung Y-Achse")
  



###########################
########## Scales  ########

# Skalen koennen manuell veraendert werden. Hilfreiche Funtkionen sind:
# - scale_y_log10()
# - scale_x_datetime()
# - scale_x_discrete()
# - scale_linetype()
# - scale_shape()

# Als Beispiel wird der iris-Datensatz hinzugezogen.

data(iris)

ggplot(iris,aes(Sepal.Length,Sepal.Width)) + 
  geom_point(aes(color=Species)) +
  scale_x_continuous(limits=c(5,7),breaks=c(5:7))

# Auch Form und Farbe koennen manuell angepasst werden.
graph2 <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(aes(color = Species,shape = Species))

graph2 + scale_colour_manual(values = c("red", "green", "blue"))
graph2 + scale_shape_manual(values = c(16, 17, 18))




###########################
########## Facetting  #####

# Facet erzeugt aus einem Datensatz Untergruppen. Fuer jede dieser Teilmengen 
# wird dieselbe Graphik erzeugt. Dieses Vorgehen ist vorteilhaft, wenn 
# untersucht werden soll, ob sich bestimmte Muster ueber den ganzen Datensatz 
# erstrecken und die Aesthetics nicht ausreichen, um verschiedene Teilmengen 
# erkennen zu können.
# -	facet_grid(. ~ variable) ordnet die Gruppen spaltenweise an
# -	facet_grid(variable ~ .) ordnet die Gruppen reihenweise an

graph2 <- ggplot(iris, aes(Sepal.Length, Sepal.Width))
graph2 + geom_point() + facet_grid(. ~ Species)
graph2 + geom_point() + facet_grid(Species ~ .)




###########################
########## Stats  #########

# Zur statistischen Transformation werden die stats in ggplot2 verwendet.
# Hilfreiche Funktionen sind:
# - stat_density() 
# - stat_quantile()
# - stat_bin()
# - stat_summary()
# - stat_unique()
# - stat_smooth()

# einfaches Beispiel:
ggplot(iris,aes(Sepal.Length,Sepal.Width))+
  geom_point()+ 
  stat_smooth(method="lm")

# Regressionsgerade fuer die einzelnen Spezien
ggplot(iris,aes(Sepal.Length,Sepal.Width,color=factor(Species)))+
  geom_point()+ 
  stat_smooth(method="lm")

# Uebersichtliche Gestaltung mit Hilfe von facet
graph2 <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()
graph2 + facet_grid(. ~ Species) + stat_smooth(method = "lm")



###############################
########## Sonstiges  #########

###########
# annotate:

# Mit annotate() können textliche Anmerkungen hinzugefuegt werden. 

standard_text = "Anmerkung"
plotmath_text <- "sum((x[i]-hat(x)), i==1, n)"
graph2 <- ggplot(iris, aes(Sepal.Width, Sepal.Length)) + geom_point()
graph2 + annotate("text", x = 3, y = 6, label = standard_text) + 
  annotate("text", x = 4, y = 7, cex = 7, label = plotmath_text, parse = TRUE)

###########
# Themes:

# Es besteht die Möglichkeit die Defaulteinstellung der ggplot Graphik durch
# theme() zu verändern. 

graph2 <- ggplot(iris, aes(Sepal.Width, Sepal.Length)) + 
  geom_point(aes(color = Species))

graph2 + theme(panel.background = element_rect(fill = "green"), 
          panel.grid.major = element_line(colour = "black"))




#################################
# ggplot fuer Zeitreihen ########

# Falls ein Objekt der Klasse 'ts' geplottet werden soll, muss dies mit Hilfe 
# von ggfortify erfolgen. ggplot erkennt sonst nicht, dass es sich um eine 
# Zeitreihe handelt.

# Um die Zeitreihe zu plotten wird der Befehl ggplot2::autoplot verwendet.
data(a10) # fpp-package
autoplot(a10)
autoplot(a10, colour = 'blue', linetype = 'dashed')

# Multivariate Zeitreihen werden von ggplot2::autoplot automatisch erkannt 
# und einzeln abgebildet.
data(Canada) #vars-package
autoplot(Canada, colour = 'blue', linetype = 'dashed')

# Falls dies nicht gewuenscht ist, kann das mit dem Argument facets = FALSE 
# verhindert werden.
autoplot(Canada, facets = FALSE,  linetype = 'dashed')

# Fuer die Darstellung koennen die selben Geoms verwendet werden, 
# die in ggplot2 vozufinden sind.
autoplot(a10, geom = 'bar', fill = 'darkgrey')
autoplot(a10, geom = 'point', shape = 2, colour ='blue')

#################
### Prognosen:

# Durch autoplot() können auch Prognosen abgenildet werden. 
# Generierung eines ARIMA Modells.
d.arima <- auto.arima(a10)

# Erstellung einer Vorhersage mithilfe des Modells.
d.forecast <- forecast(d.arima, level = c(95), h = 50)

# Plot
autoplot(d.forecast)
autoplot(d.forecast, ts.colour = 'darkgrey', predict.colour = 'red',
         predict.linetype = 'dashed', conf.int = FALSE)

#################################################################
# Darstellung von Zeitreihen die nicht der Klasse 'ts' zugehoeren.

# Aktienkurse von IBM und Linkedin von yahoo finance
ibm_url <- "http://real-chart.finance.yahoo.com/table.csv?s=IBM&a=07&b=24&c=2010&d=07&e=24&f=2015&g=d&ignore=.csv"
lnkd_url <- "http://real-chart.finance.yahoo.com/table.csv?s=LNKD&a=07&b=24&c=2010&d=07&e=24&f=2015&g=d&ignore=.csv"

# Umwandlung in data frames
dat_ibm <- read.table(ibm_url, header=TRUE, sep=",")
dat_ibm$Date <- as.Date(as.character(dat_ibm$Date))

dat_lnkd <- read.table(lnkd_url, header=TRUE, sep=",")
dat_lnkd$Date <- as.Date(as.character(dat_lnkd$Date))

# Plot der Aktienkurse
ggplot(dat_ibm,aes(Date,Close)) + 
  geom_line(aes(color="ibm")) +
  geom_line(data = dat_lnkd,aes(color="lnkd")) +
  scale_colour_manual("", breaks = c("ibm", "lnkd"),
                      values = c("blue", "red")) +
  ggtitle("Aktienkurse von IBM und Linkedin") 







