# load and preprocess data
utilities.df <- read.csv("Utilities.csv")
row.names(utilities.df) <- utilities.df[,1]
utilities.df <- utilities.df[,-1]

# normalized distance:
utilities.df.norm <- sapply(utilities.df, scale)
row.names(utilities.df.norm) <- row.names(utilities.df)

# run kmeans algorithm
km <- kmeans(utilities.df.norm, 6)

# show cluster membership
km$cluster
