# Data-Mining-Principles-SAS
MscA program_Classroom Teaching SAS Code 

# Association Rule Discovery Defined :
The rules are expressed as “if item A is part of a transaction, then item B is also part of the transaction X percent of the time.” where 0 < X ≤ 100.

# Three importance evaluation criteria: 
The strengh of an association rule is defined by its confidence factor, which is the percentage of cases in which a consequent appears with a given antecedent; 
The level of support is how frequently the combination occurs in the market basket (database); 
Lift is equal to the confidence factor divided by the expected confidence; 
A credible rule has a large relative confidence factor, a relatively large level of support, and a value of lift greater than 1. Rules with a high level of confidence but little support should be interpreted with caution. 

# Support: 
Support is the percentage of transactions that contain an itemset X: Pr(𝑋)=100%×𝑁x/𝑁 where 𝑁x is number of transactions that contain an itemset, N is the total number of transactions, support indicates the rate of occurance (relative frequency) of an itemset

# Confidence: 
Confidence is the percentage of transactions that will contain itemset Y if itemset X is already present: Pr(𝑌|𝑋)=Pr(𝑋 and 𝑌)∕Pr(𝑋), Pr(𝑌|𝑋) = (Support of X and Y) / (Support of X), Pr(𝑌|𝑋) = (Number of transactions that contain both itemset X and itemset Y) / (Number of transactions that contain itemset X), Confidence metric is the condition probability that itemset Y will be in the transaction given itemset X is already in the transaction, Confidence metric indicates how credible about the association rule: X → Y (If itemset X is in the transaction, then itemset Y will also in the transaction)

# Expected Confidence: 
Expected Confidence is, essentially, the support of itemset Y: Pr(𝑌), If occurrence of itemset X will not affect the occurrence of itemset Y, then the percentage of transactions that will contain itemset Y if itemset X is already present is basically the percentage of transactions that will contain itemset Y. Expected confidence is the confidence of the association rule X → Y under the independence assumption. 

# Lift: 
Lift is the ratio of the Confidence to Expected Confidence. Mathematically, lift value is:Pr(𝑌|𝑋)∕Pr(𝑌)  = Pr(𝑋 and 𝑌)∕(Pr(𝑋)×Pr(𝑌)) Lift indicates the effectiveness of the association rule over an independent assumption
 > 1 :  the association rule is credible and occurrence of itemset X increases occurrence of itemset Y (Pr(𝑌|𝑋)>Pr(𝑌)) 
 = 1 : the association rule is not credible and occurrence of itemset Y is independent of occurrence of itemset X (Pr(𝑌|𝑋)=Pr(𝑌)) 
 < 1 : the association rule is also credible but occurrence of itemset X actually prohibit occurrence of itemset Y (Pr(𝑌|𝑋)< Pr(Y))

# Maximum Number of Association Rules: 
Given m unique items in universal set I:
Total number of possible itemsets: 2^𝑚−1
Total number of possible association rules:3^𝑚−2^(𝑚+1)+1

# Apriori Algorithm 
Apriori algorithm constrains the search space for rules by discovering frequent itemsets and only examining rules that are made up of frequent itemsets.

Apriori algorithm proceeds in two stages:
1. It identifies frequent itemsets in the data: an itemset with support greater than or equal to the user-specified minimum support threshold. The algorithm begins by scanning the data and identifying the single-item itemsets (i.e. individual items, or itemsets of length 1) that satisfy this criterion. Any single items that do not satisfy the criterion are not be considered further, because support(A&B) ≤ support(A).
2. The second step is to select rules. For each frequent itemset L with length k > 1, the following procedure is applied: Calculate all subsets A of length of the itemset such that all the fields in A are input fields and all the other fields in the itemset (those that are not in A) are output fields. Call the latter subset. (In the first iteration this is just one field, but in later iterations it can be multiple fields.) For each subset A, calculate the evaluation measure (e.g., rule confidence) for the rule. If the evaluation measure is greater than the user-specified threshold, add the rule to the rule table, and, if the length k’ of A is greater than 1, test all possible subsets of A with length (k’ – 1).


# SAS Syntax 
# The ASSOC Procedure:  
PROC ASSOC DATA=data-set-name <options>; # DATA = data-set-name, DMDBCAT = catalog-name, OUT = data-set-name, DMDB (must specify this option if input data set is the output data set from the DMDB procedure),  ITEMS = number(maximum number of events or transactions to associate together), PCTSUP = number (minimum level of support that is needed to claim that the items are associated, refers to the largest single item frequency), SUPPORT = number (minimum number of transactions that must occur in order to accept a rule, if rules not met with this suport level, then it's rejected. Positive integer, default is 5% of the greatest item frequency count.);

CUSTOMER list-of-variables;
TARGET variable; # identifies a nominal variable that contains the purchased items and is usually ordered by customers. 

# The Rulegen Procedure: 
The rulegen procecure generates association rules based on the output of the ASSOC procedure, and computes statistics, such as confidence and lift for these rules. ASSOC identifies sets of items that are related, the RULEGEN discovers the rules that govern these assocations. 
 
PROC RULEGEN IN = data-set-name   # the input data set is the output data set from the ASSOC procedure
	     OUT = data-set-name <options>;  # only rules that meet the minimum confidence value MINCONF are saved in this data set. 
	     MINCONF = number;     # specifies the minimum confidence level that is necessary to generate a rule, default value is 10. 
RUN;



%let HomeDir = %str(/home/mllam);  /* Substitute mllam with your CNET ID */

/* Create a subdirectory: Data Mining Principles/Data under your Home Directory */
libname WK1DATA "&HomeDir./Data Mining Principles/Data/";

proc import datafile = "&HomeDir./Data Mining Principles/Data/AssociationRuleToyExample.csv"
            dbms = csv out = WK1DATA.AssociationRuleToyExample;
run;
   

proc contents data = WK1DATA.AssociationRuleToyExample;
run;


proc dmdb data = WK1DATA.AssociationRuleToyExample dmdbcat = d;
   id customer;
   class item;
   target item;
run;


proc assoc data = WK1DATA.AssociationRuleToyExample dmdbcat = d
           out = WK1DATA.assocs_out items = 4 support = 1;
   customer customer;
   target item;
run;


/* minconf = 1 gives all the eligible rules */
proc rulegen in = WK1DATA.assocs_out out = WK1DATA.rule_out minconf = 1;
run;

# Special Topics 
# Histogram of Confidence
proc sgplot data = WK1DATA.rule_out;
   histogram CONF / binwidth = 5;
   xaxis values = (0 to 100 by 5);
   yaxis grid;
run;


# Scatterplot of Support vs. Confidence 
proc sgplot data = WK1DATA.rule_out;
   where (missing(CONF) eq 0);
   scatter x = CONF y = SUPPORT;
   xaxis grid values = (0 to 100 by 5);
   yaxis grid values = (10 to 30 by 5);
run;


# Would like to know the rules where consequent is a particular itemset, e.g. what customers has also bought then lead them to buy items A and C 
proc print data = WK1DATA.rule_out;
   where (_RHAND eq "A & C");
run;

# Would like to know the rules where antecedent is a particular itemset, e.g. what customers will also buy if they already bought items A and C 
proc print data = WK1DATA.rule_out;
   where (_LHAND eq "A & C");
run;

# Use bubble statement in PROC SGPLOT to use LIFT to indicate size of the bubbles. 
proc sgplot data = WK1DATA.rule_out;
   where (missing(CONF) eq 0);
   bubble x = CONF y = SUPPORT size = LIFT;
   xaxis grid values = (0 to 100 by 5);
   yaxis grid values = (10 to 30 by 5);
run;




#Pros and Cons of Association Rules
Pros: 
Concept of itemset is very straightforward
Apriori algorithm performs well
Association rules are presented as IF/THEN statements

Cons: 
Easily generate many rules with a small number of items
Rules can be cyclic, i.e., A & B → C, A & C → B, and B & C → A
Need to filter out rules if particular items are wanted in the consequent 


# Example
/* Run the DMDB Procedure */ 
proc dmdb batch data=sampsio.assocs    dmdbcat=catRule;    id customer time;    
class product(desc); 
run; 

/* Run the ASSOC Procedure */ 
proc assoc data=sampsio.assocs    dmdbcat=catRule out=assocOut    
items=5 support=20;    
customer customer;    
target product; 
run; 

/*This code creates the data sets that are necessary to run the RULEGEN procedure*/
/*Run the RULEGEN Procedure */ 
proc rulegen in=assocOut    
out=ruleOut 
minconf=75; 
run;



















  
  
