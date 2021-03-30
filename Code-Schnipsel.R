


###########
# annotate:

# Mit annotate() k?nnen textliche Anmerkungen hinzugefuegt werden. 

standard_text = "Anmerkung"
plotmath_text <- "sum((x[i]-hat(x)), i==1, n)"
graph2 <- ggplot(iris, aes(Sepal.Width, Sepal.Length)) + geom_point()
graph2 + annotate("text", x = 3, y = 6, label = standard_text) + 
  annotate("text", x = 4, y = 7, cex = 7, label = plotmath_text, parse = TRUE)

###########
# Themes:

# Es besteht die M?glichkeit die Defaulteinstellung der ggplot Graphik durch
# theme() zu ver?ndern. 

graph2 <- ggplot(iris, aes(Sepal.Width, Sepal.Length)) + 
  geom_point(aes(color = Species))

graph2 + theme(panel.background = element_rect(fill = "green"), 
               panel.grid.major = element_line(colour = "black"))




# Durch autoplot() k?nnen auch Prognosen abgenildet werden. 
# Generierung eines ARIMA Modells.
d.arima <- auto.arima(a10)

# Erstellung einer Vorhersage mithilfe des Modells.
d.forecast <- forecast(d.arima, level = c(95), h = 50)

# Plot
autoplot(d.forecast)
autoplot(d.forecast, ts.colour = 'darkgrey', predict.colour = 'red',
         predict.linetype = 'dashed', conf.int = FALSE)