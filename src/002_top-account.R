# Set Seed
set.seed(1234)

# Load Library
library(tidyverse)
library(hrbrthemes)
library(scales)
library(lubridate)

# Load data
df <- read_rds("data/tweet-whatsappdown.rds") %>%
  mutate(created_at = as_date(created_at))

# Mencari Akun dengan Jumlah Tweet Terbanyak
top_account <- df %>%
  select(screen_name) %>%
  group_by(screen_name) %>%
  count() %>%
  ungroup() %>%
  arrange(desc(n))%>%
  slice_head(n = 5) %>%
  ggplot(aes(x = reorder(screen_name, n), y = n, fill = screen_name)) +
  geom_col(show.legend = FALSE)+
  coord_flip() +
  labs(
    x = "", y = "Jumlah Tweet",
    title = "#WhatsAppDown",
    subtitle = "Akun dengan Jumlah Tweet Terbanyak", 
    caption = bquote(bold("Dianalisis Oleh") ~ "Muhammad Apriandito")
  ) +
  theme_ipsum_tw()

# Simpan Plot
ggsave(top_account,
       filename = "plot/top_account.png",
       width = 20,
       height = 20,
       dpi = 300,
       type = "cairo",
       units = "cm",
       limitsize = FALSE
)
