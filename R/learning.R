
# Exercises: piping, filtering etc ----------------------------------------

# Load packages

library(tidyverse)
library(NHANES)

# Looking at data
glimpse(NHANES)

# Selecting columns
select(NHANES, Age)

select(NHANES, Age, Weight, BMI)

select(NHANES, -HeadCirc)

select(NHANES, starts_with("BP"))

select(NHANES, ends_with("Day"))

select(NHANES, contains("Age"))

# Create smaller NHANES dataset
nhanes_small <- select(
  NHANES, Age, Gender, BMI, Diabetes,
  PhysActive, BPSysAve, BPDiaAve, Education
)

# Renaming columns
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

nhanes_small

# Renaming specific columns
nhanes_small <- rename(nhanes_small, sex = gender)

# Trying out the pipe
colnames(nhanes_small)

nhanes_small %>%
  colnames()

nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

# Exercise 7.8

# Selecting BP and education status
nhanes_small %>%
  select(bp_sys_ave, education)

# Renaming BP sys and dia (New = old)

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

# Using pipe operator for this piece of code, then filtering age > 50

select(nhanes_small, bmi, contains("age"))

nhanes_small %>%
  select(bmi, contains("age")) %>%
  filter(age > 50)

# rewriting the following code with piping (again9:
blood_pressure <- select(nhanes_small, starts_with("bp_"))
rename(blood_pressure, bp_systolic = bp_sys_ave)

nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)

# filtering
nhanes_small %>%
  filter(phys_active != "No")

nhanes_small %>%
  filter(bmi >= 25)

# Combining logial operators
nhanes_small %>%
  filter(bmi >= 25 & phys_active == "No")

nhanes_small %>%
  filter(bmi >= 25 | phys_active == "No")

# Arrange data
nhanes_small %>%
  arrange(desc(age))

nhanes_small %>%
  arrange(education, age)

# Transforming data
nhanes_small %>%
  mutate(age = age * 12)

nhanes_small %>%
  mutate(age_in_months = age * 12)

nhanes_small %>%
  mutate(logged_BMI = log(bmi))

nhanes_small %>%
  mutate(old = if_else(age >= 30, "Yes", "No"))

styler:::style_active_file()

# Exercise 7.12

# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>%
    mutate(mean_arterial_pressure = (((2*bp_dia_ave)+bp_sys_ave)/3)) %>%
    mutate(young_child = if_else(age < 6, "Yes", "No"))

nhanes_modified



