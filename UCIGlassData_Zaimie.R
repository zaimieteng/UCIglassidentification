####Exploring and preparing the data####
glass <- read.csv("C:/Users/Admin/OneDrive/MsC in Analytics/AY2024 Tri 1/Analytics Software I/IndivAssignment/UCiglass+identification/glass.csv",
                  stringsAsFactors = FALSE)

# Install relevant packages
requiredPackages <- c("class", "gmodel","ggplot2")
if (length(setdiff(requiredPackages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(requiredPackages, rownames(installed.packages())))  
}
library(class)
library(gmodels)
library(ggplot2)

summary(glass)
# No missing values

# Remove Id column
glass <- glass[-1]
str(glass)

# Distribution of type of glass
table(glass$TypeOfGlass)

# Randomise rows as data is sorted by type of glass
shuffled_glass <- glass[sample(1:nrow(glass)),]
shuffled_glass

# Normalise numeric data
# Set normalise function
normalise <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}
# Normalise data
glass_n <- as.data.frame(lapply(shuffled_glass[1:9],normalise))
# Check values
summary(glass_n$Si)

# Split data into training and test datasets
glass_train <- glass_n[1:171, ]
glass_test <- glass_n[172:214, ]
glass_train_labels <- shuffled_glass[1:171, 10]
glass_test_labels <- shuffled_glass[172:214, 10]
sqrt(214)
glass_pred <- knn(train=glass_train, test=glass_test,
                  cl=glass_train_labels, k=14)

# Evaluation
CrossTable(x=glass_test_labels, y=glass_pred,
           prop.chisq = FALSE)
# Create logical vector where TRUE = mismatch
misclass <- mean(glass_pred!=glass_test_labels)
# Print out percentage of matches
print(paste('Accuracy(%)=',(1-misclass)*100))


# Test with different values of k
# Plot graph of k values
k_values <- c(1:20)
accuracy_values <- sapply(k_values,function(k){
  glass_pred <- knn(train=glass_train, test=glass_test,
                    cl=glass_train_labels, k=k)
  1 - mean(glass_pred!=glass_test_labels)
})
# Create data frame to plot graph
accuracy_df <- data.frame(K = k_values, Accuracy = accuracy_values)

# Plot
ggplot(accuracy_df, aes(x=K, y=Accuracy))+
  geom_line(color = "lightgreen", linewidth = 1)+
  geom_point(color = "darkgreen", size = 3)+
  labs(title="Accuracy for different K values",
       x = "k value",
       y = "Accuracy")+
  theme_minimal()

glass_pred <- knn(train=glass_train, test=glass_test,
                  cl=glass_train_labels, k=5)
misclass <- mean(glass_pred!=glass_test_labels)
print(paste('Accuracy(%)=',(1-misclass)*100))

# Test accuracy with z-score standardisation
glass_z <- as.data.frame(scale(shuffled_glass[1:9]))
summary(glass_z$Si)

glass_z_train <- glass_z[1:171, ]
glass_z_test <- glass_z[172:214, ]
glass_z_train_labels <- shuffled_glass[1:171, 10]
glass_z_test_labels <- shuffled_glass[172:214, 10]

glass_z_pred <- knn(train=glass_z_train, test=glass_z_test,
                    cl=glass_z_train_labels, k = 14)
CrossTable(x = glass_z_test_labels, y = glass_z_pred,
           prop.chisq = FALSE)
misclassz <- mean(glass_z_pred!=glass_z_test_labels)
print(paste('Accuracy(%)=',(1-misclassz)*100))


# Test fot k values using z-score standardised data
k_values <- c(1:20)
accuracy_values <- sapply(k_values,function(k){
  glass_z_pred <- knn(train=glass_z_train, test=glass_z_test,
                      cl=glass_z_train_labels, k = k)
  1 - mean(glass_z_pred!=glass_z_test_labels)
})
# Create data frame to plot graph
accuracy_df <- data.frame(K = k_values, Accuracy = accuracy_values)

# Plot
ggplot(accuracy_df, aes(x=K, y=Accuracy))+
  geom_line(color = "lightgreen", linewidth = 1)+
  geom_point(color = "darkgreen", size = 3)+
  labs(title="Accuracy for different K values",
       x = "k value",
       y = "Accuracy")+
  theme_minimal()

# Print out highest accuracy result
glass_z_pred <- knn(train=glass_z_train, test=glass_z_test,
                    cl=glass_z_train_labels, k = 5)
misclassz <- mean(glass_z_pred!=glass_z_test_labels)
print(paste('Accuracy(%)=',(1-misclassz)*100))
