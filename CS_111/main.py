######################################################
# Project: Lab_2
# UIN: 670246811
# URL to your repl.it project: https://repl.it/@ysemik2/lab2670246811
######################################################

meal_chosen = False
meal = ""
pizza_size = ""
while meal_chosen == False:
  meal = input('What do you want to order?\n')
  price = 0
  if meal == "Pizza":
      pizza_size = input("What size do you want to have?\n")
      if pizza_size == "Small":
        meal_chosen = True
        price+=6
      elif pizza_size == "Medium":
        meal_chosen = True
        price+=10
      elif pizza_size == "Large":
        meal_chosen = True
        price+=15
      else:
        print("Choose the size correctly please!")
  elif meal == "Biryani":
    meal_chosen = True
    price+=8
  elif meal == "Burrito":
    meal_chosen = True
    price+=8
  else :
      print("I'm sorry, we don't have that.")

delivery_chosen = False
delivery = ""
if meal_chosen == True:
  delivery = input('Pickup or Delivery?\n')
  if delivery == "Delivery":
    delivery_chosen = True
    price+=5
  else:
    delivery_chosen = True



if delivery_chosen == True and meal_chosen == True:
  if meal == "Pizza":
    print("Your order: ", meal, " ", pizza_size, " for ", delivery)
  else:
    print("Your order: ", meal, " for ", delivery)
  print("Your cost: $", price)