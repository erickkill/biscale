# lendo as bibliotecas
library('sf')
library('biscale')
library('cowplot')
library('ggplot2')

# setando o diretório
file.path("..", "shp")

# carregando o shapefile
shape <- read_sf('SP_final.shp')

# criando as classes e setando na função quantil
data <- bi_class(shape, x = 'HOMENS', y = 'MULHERES', style = "quantile", dim = 3)


# criando o mapa
mapa <- ggplot() +
  geom_sf(data = data, mapping = aes(fill = bi_class), color = "black", size = 0.1, show.legend = FALSE) +
  bi_scale_fill(pal = "DkBlue", dim = 3) +
  labs(
    title = "Municípios de SP",
    subtitle = "Total de população masculina x feminina"
  ) +
  bi_theme()

#criando a legenda
legenda <- bi_legend(pal = "DkBlue",
                    dim = 3,
                    xlab = "Homens",
                    ylab = "Mulheres",
                    size = 10)


# combinando mapa com legenda (os números setam as posições da legenda e mapa na plotagem)
finalPlot <- ggdraw() +
  draw_plot(mapa, 0, 0, 1, 1) +
  draw_plot(legenda, 0, .1, 0.6, 0.2) 

finalPlot