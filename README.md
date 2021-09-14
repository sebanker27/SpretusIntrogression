# SpretusIntrogression
Code associated with Bidirectional Introgression between Mus musculus domestics and Mus spretus (Banker, Bonhomme, and Nachman, 2021)

Sliding window Dxy:
Code1:<Dxy_GenomeScan_POP> 
Input files: Harr AllMouse.vcf
       SpretEiJ genome
Output files: fixedSpretsites_8POP_Genotypes_14JUN2019_mm10sitesRem.txt


Code2: <POP_Loop>
	Input files: fixedSpretsites_8POP_Genotypes_14JUN2019_mm10sitesRem.txt
	Output files: 	POP1_Combined_PerDiv_10kbwind.txt
POP2_Combined_PerDiv_10kbwind.txt
POP3_Combined_PerDiv_10kbwind.txt
POP4_Combined_PerDiv_10kbwind.txt
POP5_Combined_PerDiv_10kbwind.txt
POP6_Combined_PerDiv_10kbwind.txt
POP7_Combined_PerDiv_10kbwind.txt
POP8_Combined_PerDiv_10kbwind.txt

Define Threshold Values for Homozygous Windows
	Row 5 = Heterospecific Dxy
	Row 8 = Conspecific Dxy
	Row 9 = Difference Dxy <-- this is the column that is filtered based on the thresholds

Define Threshold Values for Heterozygous Windows
Row 5 = Heterospecific Dxy
	Row 8 = Conspecific Dxy
	Row 9 = Difference Dxy <-- this is the column that is filtered based on the thresholds

Define Windows that have introgressed into the Reference Genome
	Code: <DetectReferenceIntrogression_workfile.txt> 
	Input files: 	POP1_Combined_PerDiv_10kbwind.txt
POP2_Combined_PerDiv_10kbwind.txt
POP3_Combined_PerDiv_10kbwind.txt
POP4_Combined_PerDiv_10kbwind.txt
POP5_Combined_PerDiv_10kbwind.txt
POP6_Combined_PerDiv_10kbwind.txt
POP7_Combined_PerDiv_10kbwind.txt
POP8_Combined_PerDiv_10kbwind.txt
Output files: 	test1.txt <-- windows for all individuals in single file (there should be 8 of these files, one for each individual in the population) 
