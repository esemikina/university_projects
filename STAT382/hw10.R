## WH 10
## Yelizaveta Semikina
 


# Question 1
mydata <- read.csv("/Users/liza/Desktop/STAT382/breast_cancer_v3.csv")

is.na(mydata)
# result
It returns FALSE, thus, there are no missing values. 



# Question 2
cor(mydata)
# result
                     Age    Tumor_size   Inv_nodes   Deg_malig       Pain
Age         1.0000000000 -0.0002889673 -0.07993397 -0.08853445 0.01217400
Tumor_size -0.0002889673  1.0000000000  0.15334089  0.16479095 0.04153558
Inv_nodes  -0.0799339677  0.1533408905  1.00000000  0.33048133 0.22009364
Deg_malig  -0.0885344518  0.1647909537  0.33048133  1.00000000 0.53712790
Pain        0.0121739972  0.0415355836  0.22009364  0.53712790 1.00000000



# Question 3

cor = 0.1533408905, it means there is weak linear relationshop between Tumor_size and Inv_nodes. 



# Question 4.a
H0: r = 0
H1: r != 0



# Question 4.b
cor.test(mydata$Tumor_size, mydata$Inv_nodes)
# result
Pearsons product-moment correlation

data:  mydata$Tumor_size and mydata$Inv_nodes
t = 2.5733, df = 275, p-value = 0.0106
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.03613849 0.26638231
sample estimates:
      cor 
0.1533409



# Question 4.c
p-value is 0.0106



# Question 4.d
Do not reject because the p value is a little bigger than significnace level of 0.01. 



# Question 4.e
There is not enough evidence that there is a linear relationships between tumor size and inv nodes. 



# Question 5
cor(mydata, method = "spearman")
# result
                   Age  Tumor_size   Inv_nodes   Deg_malig       Pain
Age         1.00000000 -0.01891250 -0.05201105 -0.08034734 0.01792901
Tumor_size -0.01891250  1.00000000  0.22872048  0.20003645 0.06488941
Inv_nodes  -0.05201105  0.22872048  1.00000000  0.26661663 0.19978308
Deg_malig  -0.08034734  0.20003645  0.26661663  1.00000000 0.54440980
Pain        0.01792901  0.06488941  0.19978308  0.54440980 1.00000000
 
rho is 0.22872048. There is a weak linear relationship between Tumor Size and Inv Nodes. 



# Question 6.a
H0: p = 0
H1: p != 0



# Question 6.b
cor.test(mydata$Tumor_size, mydata$Inv_nodes, method = "spearman", exact = FALSE)
# result
SpearmanS rank correlation rho

data:  mydata$Tumor_size and mydata$Inv_nodes
S = 2732085, p-value = 0.0001228
alternative hypothesis: true rho is not equal to 0
sample estimates:
  rho 
0.2287205 



# Question 6.c
p value is 0.0001228.



# Question 6.d
Reject H0.
p-value is small.


# Question 6.e
There is evidence of relationship between tumor size and inv nodes.



# Question 7.a
H0: T = 0
H1: T != 0



# Question 7.b
cor(mydata,  method = "kendall")
# result
                  Age  Tumor_size   Inv_nodes   Deg_malig       Pain
Age         1.00000000 -0.01327564 -0.03809012 -0.06338433 0.01384239
Tumor_size -0.01327564  1.00000000  0.16965188  0.15912744 0.05257272
Inv_nodes  -0.03809012  0.16965188  1.00000000  0.22632035 0.15980793
Deg_malig  -0.06338433  0.15912744  0.22632035  1.00000000 0.48155577
Pain        0.01384239  0.05257272  0.15980793  0.48155577 1.00000000



# Question 7.c
cor.test(mydata$Deg_malig, mydata$Pain, method = "kendall")
# result
Kendalls rank correlation tau

data:  mydata$Deg_malig and mydata$Pain
z = 9.4146, p-value < 2.2e-16
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.4815558 



# Question 7.d
p-value is < 2.2e-16. 



# Question 7.e
Reject H0.
p-value is small. 



# Question 7.f
There is evidence of ordinal relationship between degree of malignancy and pain. 









































