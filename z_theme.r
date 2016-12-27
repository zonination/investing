z_theme <- function() {
  theme_bw(base_size=9) +
    #Background and Grid formatting
    theme(panel.background=element_rect(fill="#F0F0F0", color="#F0F0F0")) +
    theme(plot.background=element_rect(fill="#F0F0F0", color="#F0F0F0")) +
    theme(panel.border=element_rect(color="#F0F0F0")) +
    theme(panel.grid.major=element_line(color="#969696",size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    #Legend formatting
    theme(legend.background = element_rect(fill="#F0F0F0")) +
    theme(legend.text = element_text(size=14,color="#525252")) +
    theme(legend.title= element_blank())+
    #Axis & Title Formatting
    theme(plot.title=element_text(color="#525252", size=20, vjust=1.25)) +
    theme(plot.subtitle=element_text(size=12,color="#737373", vjust=0)) +
    theme(plot.caption=element_text(size=12,color="#737373", vjust=0)) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text.x=element_text(size=14,color="#737373")) +
    theme(axis.text.y=element_text(size=14,color="#737373")) +
    theme(axis.title.x=element_text(size=16,color="#737373", vjust=0)) +
    theme(axis.title.y=element_text(size=16,color="#737373", vjust=.5))
}