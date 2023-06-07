import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import plotly.express as px
import plotly.graph_objects as go
import seaborn as sns

data = pd.read_csv("titanic.csv")

# First task
def table_gender():
  male_sur = data.query('Survived == 1 & Sex == "male"')
  female_sur = data.query('Survived == 1 & Sex == "female"')
  male_nsur = data.query('Survived == 0 & Sex == "male"')
  female_nsur = data.query('Survived == 0 & Sex == "female"')
  d = [
    [len(male_sur), len(female_sur)],
    [len(male_nsur), len(female_nsur)]
  ]
  res_table = pd.DataFrame(data=d, index=['Suvived', 'Died'], columns=['Male', 'Female'])

  res_table.plot(kind='pie', subplots=True, figsize=(8, 4), autopct='%1.1f%%')
  plt.show()
  return res_table

#Second task
def table_class():
  #survived
  class1_sur = data.query('Survived == 1 & Pclass == 1')
  class2_sur = data.query('Survived == 1 & Pclass == 2')
  class3_sur = data.query('Survived == 1 & Pclass == 3')

  #died
  class1_nsur = data.query('Survived == 0 & Pclass == 1')
  class2_nsur = data.query('Survived == 0 & Pclass == 2')
  class3_nsur = data.query('Survived == 0 & Pclass == 3')

  d = [
    [len(class1_sur), len(class2_sur), len(class3_sur)],
    [len(class1_nsur), len(class2_nsur), len(class3_nsur)],
  ] 
  res_table = pd.DataFrame(data=d, index=['Suvived', 'Died'], columns=['First class', 'Second class', 'Third class'])
  return res_table

#Third task
def table_age():
  sur = data.query('Survived == 1')
  sur = sur.dropna(subset=['Age'])
  nsur = data.query('Survived == 0')
  nsur = nsur.dropna(subset=['Age'])
  sur_ages = sur['Age']
  nsur_ages = nsur['Age']

  fig, axs = plt.subplots(1, 2, figsize=(10, 5))
  axs[0].set_xlabel('Age')
  axs[0].set_ylabel('Frequency')
  axs[1].set_xlabel('Age')
  axs[1].set_ylabel('Frequency')

  sur_ages.plot.hist(ax=axs[0], title='Survived')
  nsur_ages.plot.hist(ax=axs[1], title='Not Survived')

  fig.suptitle('Histograms of Ages for Survived and Not Survived Passengers')
  plt.show()

  return sur_ages, nsur_ages

#Fourth task
def table_price():
  sur_exp =  data.query('Survived == 1 and Fare >= 25')
  sur_cheap = data.query('Survived == 1 and Fare < 25')

  nsur_exp =  data.query('Survived == 0 and Fare >= 25')
  nsur_cheap = data.query('Survived == 0 and Fare < 25')
  d = [
    [len(sur_cheap), len(sur_exp)],
    [len(nsur_cheap), len(nsur_exp)]
  ]
  res_table = pd.DataFrame(data=d, index=['Survived', 'Died'], columns=['Cheap', 'Expensive'])

  #visualization
  res_table.plot(kind='pie', subplots=True, figsize=(12, 4), autopct='%1.1f%%')
  plt.show()

  fig = px.pie(res_table, values='Cheap', names='Cheap', title='Correlation between price and mortality')
  fig.show()

  return res_table

table_price()