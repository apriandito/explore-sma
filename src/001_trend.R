# Set Seed
set.seed(1234)

# Load Library
library(tidyverse)
library(hrbrthemes)
library(scales)
library(lubridate)

# Load data
df <- read_rds("data/tweet-whatsappdown.rds")

# Plot Trend
trend <- df %>%
  mutate(created_at = created_at + 7 * 60 * 60) %>%
  mutate(tanggal = floor_date(created_at, "2 hours")) %>%
  group_by(tanggal) %>%
  count() %>%
  ggplot(aes(x = tanggal, y = n)) +
  geom_line(colour = "#f8766d", size = 0.7) +
  geom_point(colour = "grey30", size  = 1.5, alpha = 0.7) +
  geom_text(aes(label = n),
            vjust = "inward", hjust = "inward", size = 3, colour = "grey30",
            show.legend = FALSE, family = 'Titillium Web'
  ) +
  labs(
    x = "", y = "Jumlah Tweet",
    title = "#WhatsAppDown",
    subtitle = "Trend Penggunaan Hashtag Di Twitter", 
    caption = bquote(bold("Dianalisis Oleh") ~ "Muhammad Apriandito")
  ) +
  scale_y_continuous(breaks = pretty_breaks()) +
  theme_ipsum_tw()

# Simpan Visualisasi
ggsave(trend,
       filename = "plot/trend.png",
       width = 20,
       height = 20,
       dpi = 300,
       type = "cairo",
       units = "cm",
       limitsize = FALSE
)

