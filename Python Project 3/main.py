# valArr = []
# counters = {}

# # parse
# with open('retail.txt', 'r') as f:
#     data = f.readlines()

# for line in data:
#     line = line.strip().split()
#     products = line[0:]
#     valArr.append(" ".join(products))


# def updateCnt(key):
#     if key in counters:
#         counters[key] += 1
#     else:
#         counters[key] = 1

# def process(prodId1, prodId2):
#     if int(prodId1) != 0:
#         updateCnt(prodId1)

#     if int(prodId2) != 0:
#         updateCnt(prodId2)
    
#     if int(prodId1) != 0 and int(prodId2) != 0:
#         updateCnt("_".join([prodId1, prodId2]))
        

# for i in range(len(valArr)):
#     currEl = valArr[i]
#     if(len(currEl) > 0):
#         parsedArr = currEl.split(' ')
#         id, prod1, prod2 = parsedArr
#         process(prod1, prod2)

# sortedByValsDESC = sorted(counters.items(), key = lambda x:x[1], reverse = True)

# first10ns=[[], []]
# # find first 10s
# for i in range(len(sortedByValsDESC)):
#     # tuple 
#     key, counter = sortedByValsDESC[i]
#     if len(key) <= 2:
#         if(len(first10ns[0]) <= 9):
#             first10ns[0].append((key, counter))
#     else:
#         if(len(first10ns[1]) <= 9):
#             first10ns[1].append((key, counter))

# with open('output.txt', 'w') as f:
#     f.write('Top 10 most popular products:\n')
#     for product in first10ns[0]:
#         f.write('{}\t{}\n'.format(product[0], product[1]))
#     f.write('\nTop 10 most commonly copurchased product pairs:\n')
#     for product_pair in first10ns[1]:
#         f.write('{}\t{}\n'.format(" and ".join(product_pair[0].split('_')), product_pair[1]))


def import_stock(file):
    stock = {}
    with open(file, 'r') as f:
        for line in f:
            name, quantity = line.strip().split(',')
            stock[name] = int(quantity)
    return stock

def gen_stats(stock):
    total = sum(stock.values())
    average = total / len(stock)
    maximum = max(stock.values())
    minimum = min(stock.values())
    print("Total amount: ", total)
    print("Average: ", average)
    print("Maximum: ", maximum)
    print("Minimum: ", minimum)

def check_stock(stock, product):
    if product in stock:
        print("The number is: ", stock[product])
    else:
        print("We don't have this product")

def update_stock(stock, product, quantity):
    if product in stock:
        stock[product] = quantity
        print("The updated dictionary is: ", stock)
    else:
        print("We don't have this product")

stock = import_stock("stocks.txt")

while True:
    print("1. Generate overall stats for all products")
    print("2. Calculate the amount of a given product")
    print("3. Update the amount for a given product")
    print("4. Quit")
    choice = input("Enter your choice (1-4): ")

    if choice == '1':
        gen_stats(stock)
    elif choice == '2':
        product = input("Enter a product name: ")
        check_stock(stock, product)
    elif choice == '3':
        product, quantity = input("Enter a product name and a number: ").split(' ')
        update_stock(stock, product, int(quantity))
    elif choice == '4':
        break
    else:
        print("Invalid choice. Try again.")
