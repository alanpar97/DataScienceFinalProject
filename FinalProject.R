# Getting started
library(healthcareai)

#Taking a look at dataset
str(pima_diabetes)

#Quick modeling
quick_models <- machine_learn(pima_diabetes, patient_id, outcome = diabetes)

quick_models

predictions <- predict(quick_models)
predictions
plot(predictions)

#Quick prediction with quick modeling
quick_models %>% predict(outcome_groups = 2) %>% plot()

#Data Profiling
missingness(pima_diabetes) %>% plot()

#Data Preparation
split_data <- split_train_test(d = pima_diabetes, outcome = diabetes, p= .9, seed = 84105)

prepped_training_data <- prep_data(split_data$train, patient_id, outcome = diabetes, center = TRUE, scale = TRUE, collapse_rare_factors = FALSE)

#Model Training
models <- tune_models(d = prepped_training_data, outcome = diabetes, tune_depth = 25, metric = "PR")

#Evaluate
evaluate(models, all_models = TRUE)

models["Random Forest"] %>% plot()

#Interpretation 
interpret(models) %>% plot()

#Variable importance
get_variable_importance(models) %>% plot()

#Exploration
explore(models) %>% plot()

#Prediction
predict(models)

test_predictions <- predict(models, split_data$test, risk_groups = c(low = 30, moderate = 40, high = 20, extreme = 10))

plot(test_predictions)

