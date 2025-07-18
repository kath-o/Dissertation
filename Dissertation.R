
#Chlorophyll fluorescence trial analysis 

    #Loading data
    cftrial <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/CFtrial.csv")
    
    #Installing + loading packages
    install.packages("lme4")
    install.packages("lmerTest")
    install.packages("Matrix", dependencies = TRUE, type = "source")
    
    library(lme4)
    library(lmerTest)
    
    #Convert categorical variables to factors
    cftrial$plot <- as.factor(cftrial$plot)
    cftrial$time <- as.factor(cftrial$time)
    cftrial$plant <- as.factor(cftrial$plant)
    cftrial$leaf <- as.factor(cftrial$leaf)
    
    #LMM for sources of variation 
    cftrialmodel <- lmer(FvFm ~ plot * time + 
                           (1|plot:plant) + 
                           (1|plot:plant:leaf),
                         data = cftrial)
    
    summary(cftrialmodel)
    
    

#Preliminary germination plots 

    #Loading data 
    germdata <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/germsummary.csv")
    
    #Installing and loading packages 
    install.packages("ggplot2")
    library(ggplot2)
    
    #Plots
    
    ggplot(germdata, aes(x = Date, y = Seedlings, color = Plot, group = Plot)) +
      geom_line() +
      geom_point() +
      theme_minimal() +
      labs(title = "Germination Over Time",
           x = "Date",
           y = "Number of Seedlings")
    
    ggplot(germdata, aes(x = Date, y = Total, color = Plot, group = Plot)) +
      geom_line() +
      geom_point() +
      theme_minimal() +
      labs(title = "Total plants",
           x = "Date",
           y = "Total number of plants")
    
    
    

#Chlorophyll fluorescence plots and analysis 
    
    #Loading data
    CFdata <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/CFdata.csv")
    CFplot1 <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/CFone.csv")
    CFplot2 <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/CFtwo.csv")

    #Plots 
    
    install.packages("patchwork")
    library(patchwork)
    
    p1 <- ggplot(CFplot1, aes(x = plot, y = FvFm, fill = treatment)) +
      geom_boxplot(outlier.size = 0.8) +
      scale_fill_manual(values = c(
          "NoAdmixture" = "aquamarine3",  # blue
          "LocalAdmixture" = "royalblue2",  # green
          "CoreEdge" = "lightpink1",  # red
          "RefugiumEdge" = "gold1"   # orange
        )) + theme_minimal() +
      geom_jitter(shape = 1, width = 0.2, alpha = 0.7, size = 0.6, colour = "black") + 
      xlab("Plot") + ylab("Chlorophyll Fluoresence (Fv/Fm)") + labs(fill="Admixture Combination") +
      ggtitle("Independent replicate 1")
        
    p2 <- ggplot(CFplot2, aes(x = plot, y = FvFm, fill = treatment)) +
      geom_boxplot(outlier.size= 0.8) +
        scale_fill_manual(values = c(
          "NoAdmixture" = "aquamarine3",  # blue
          "LocalAdmixture" = "royalblue2",  # green
          "CoreEdge" = "lightpink1",  # red
          "RefugiumEdge" = "gold1"   # orange
        )) + theme_minimal() +
      geom_jitter(shape = 1, width = 0.2, alpha = 0.7, size = 0.6, colour ="black") +
      xlab("Plot") + ylab("Chlorophyll Fluoresence (Fv/Fm)") + labs(fill="Admixture Combination") +
      ggtitle("Independent replicate 2")
    
    p1 / p2 + plot_annotation(title = "Chlorophyll Fluorescence Across Admixture Combinations")
    
    
    #Analysis 
    
    #Installing + loading packages
    
    #install.packages("lme4")
    #install.packages("lmerTest")
    #install.packages("Matrix", dependencies = TRUE, type = "source")
    
    library(lme4)
    library(lmerTest)
    
    #Convert categorical variables to factors
    CFdata$Block <- as.factor(CFdata$Block)
    CFdata$Plant <- as.factor(CFdata$Plant)
    CFdata$Leaf <- as.factor(CFdata$Leaf)
    CFdata$Day <- as.factor(CFdata$Day)
    
    
    CFmodel <- lmer(
      FvFm ~ Treatment +                       
        (1 | Block) +                           
        (1 | Day) +                              
        (1 | Plant) +                            
        (1 | Plant:Leaf),                        
      data = CFdata
    )
    
    summary(CFmodel)



#Height plots and analysis 
    
    #Loading data
    earlyheight <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/earlyheight.csv")
    lateheight <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/lateheight.csv")

    #Plots
  
    p3 <- ggplot(earlyheight, aes(x = Plot, y = Height, fill = Treatment)) +
      geom_boxplot() +
      scale_fill_manual(values = c(
        "NoAdmixture" = "aquamarine3",
        "LocalAdmixture" = "royalblue2",
        "CoreEdge" = "lightpink1",
        "RefugiumEdge" = "gold1"
      )) +
      theme_minimal() +
      geom_jitter(shape = 1, width = 0.2, alpha = 0.7, size = 0.6, colour = "black") +
      xlab("Plot") +
      ylab("Plant Height (mm)") + ggtitle("Early Season") + labs(fill="Admixture Combination")
    
    p4 <- ggplot(lateheight, aes(x = Plot, y = Height, fill = Treatment)) +
      geom_boxplot() +
      scale_fill_manual(values = c(
        "NoAdmixture" = "aquamarine3",
        "LocalAdmixture" = "royalblue2",
        "CoreEdge" = "lightpink1",
        "RefugiumEdge" = "gold1"
      )) +
      theme_minimal() +
      geom_jitter(shape = 1, width = 0.2, alpha = 0.7, size = 0.6, colour = "black") +
      xlab("Plot") +
      ylab("Plant Height (mm)") + ggtitle("Late Season") + labs(fill="Admixture Combination")
    
    p3 / p4 + plot_annotation(title = "Plant Height Across Admixture Combinations")
    
    
    #Analysis
    
    earlyheightmodel <- lmer(Height ~ Treatment + (1 | Block), data = earlyheight)
    summary(earlyheightmodel)
    
    lateheightmodel <- lmer(Height ~ Treatment + (1 | Block), data = lateheight)
    summary(lateheightmodel)
    
    #install.packages("emmeans")
    library(emmeans)
    emmeans(earlyheightmodel, pairwise ~ Treatment, adjust = "tukey")
    emmeans(lateheightmodel, pairwise ~ Treatment, adjust = "tukey")
    


#Germination plots and analysis 
    
    #Cumulative germination plots 
    
    cgerm2 <- read.csv("~/Desktop/MSc EEB/WD/Dissertation/cgerm2.csv")
    
    ggplot(cgerm2, aes(x = Timepoint, y = Cumulative, color = Plot, group = Plot)) +
      geom_line() +
      geom_point() +
      theme_minimal() +
      labs(title = "Germination Over Time",
           x = "Date",
           y = "Number of Seedlings")

