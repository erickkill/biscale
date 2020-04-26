# lendo as bibliotecas (caso as bibliotecas não estejam instaladas, executar o comando install.packages("nome da lib")
library('sf')
library('biscale')
library('cowplot')
library('ggplot2')

# setando o diretório (aqui se edita de acordo com o nome da pasta em que o .shp e o script estão inseridos)
file.path("..", "biscale")

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

# combinando mapa com a legenda (os números setam as posições da legenda e do mapa na plotagem)
finalPlot <- ggdraw() +
  draw_plot(mapa, 0, 0, 1, 1) +
  draw_plot(legenda, 0, .1, 0.6, 0.2) 

finalPlot
