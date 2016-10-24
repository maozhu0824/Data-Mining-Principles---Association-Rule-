/*Cluster Analysis*/
/*HPCLUS uses only numeric interval variables or only nomial variables to 
perform clustering, not perform clustering for mixed levels of input variables*/
/*Syntax:

PROC HPCLUS <options>;
	INPUT variables / <options>;
	ID variables;
	SCORE options;
	CODE <options>;
RUN;

INPUT statement is required, Multiple INPUT statements are allowed. 

<options>: 
DATA = <LIBREF.>SAS-data-set
OUTSTAT = <LIBREF.>SAS-data-set
##Contents of OUTSTAT dataset: _ITERATION_, _CLUSTER_ID_, Cluster centroids 
in originial scale, cluster centroids in standardized scale(STANDARDIZE)
MAXCLUSTERS = positive integer, default is 6
NOC = NONE/ABC, default is none. 
##options under ABC: MINICLUSTERS = minimum number of clusters, default is 2. 
			CRITERION = GLOBALPEAK/FIRSTPEAK/FIRSTMAXWITHSTD/ALL
DISTANCE = EUCLIDEAN/MANHATTAN (distance for interval, euclidean is default)
DISTANCENOM = BINARY/GLOBALFREQ/RELATIVEFREQ (distance for categorical, befault
is binary)
IMPUTE = MEAN/NONE (imputation method for interval variables, default is none)
IMPUTENOM = MODE/NONE (imputation method for nominal variables,default is NONE)
MAXITER = positive integer (maximum number of iterations, default is 10)
SEED = positive integer between 1 and 2^31 - 1
STANDARDIZE = NONE/RANGE/STD (standardization method for interval variables,
default is NONE.)

INPUT #names of variables to be used in clustering. NOC for interval variables
INPUT variables
</LEVEL = BINARY/NOMINAL/INTERVAL>;

ID #variables from input dataset that are transferrd to SCORE output dataset, 
otherwise the output dataset will contain only cluster identifier and distance
from the cluster's centroid. 

SCORE #writes cluster membership information of each observation to the output
dataset, including variables in ID statement and two new: _CLUSTER_ID_, _DISTANCE_
SCORE <OUT = <LIBREF.>SAS-data-set>;

CODE　#generates SAS DATA step code that mimics the computations that are done
by the SCORE statement. 
CODE <FILE = filename>;


/* Generated Code (IMPORT) */
/* Source File: DistanceFromChicago.xlsx */
/* Source Path: /home/maozhu20120 */
/* Code generated on: 10/23/16, 4:33 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/maozhu20120/DistanceFromChicago.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);



PROC HPCLUS data = WORK.IMPORT
	MAXCLUSTERS = 8  SEED = 20161018  NOC = ABC(MINCLUSTERS = 2)
	OUTSTAT = HPCLUS_OutStat;
     ID City StateCode;
     INPUT DrivingMilesFromChicago / LEVEL = INTERVAL;
     CODE FILE = '/home/maozhu20120/HPCLUS_Code.sas';
     SCORE OUT = WORK.HPCLUS_Score;
RUN;

 
PROC GMAP MAP = MAPS.US
	DATA = WORK.HPCLUS_SCORE;
    ID StateCode;
    CHORO _CLUSTER_ID_ / DISCRETE;
RUN;
QUIT;




     

