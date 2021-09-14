#!/usr/bin/sh
#
#MODIFIED FROM KATYA MACK for Mcaroli, mm10 liftover by SEB March2018
#
# download modules and make them excutable
	#axtChain  chainMergeSort  chainSplit  faSplit  netChainSubset
	#blat      chainNet        faSize      liftUp   twoBitToFa
# chmod +x twoBitToFa
# download mm10.2bit and convert it to fasta format
# split Mcaroli into individual chromosome/scaffold/chunks (Mcaroli_chr$i.fa) and save them into ./Mcaroli_chr direcotry - remember to change paths if you change this!
# Note: I did this with a personal script manually, but you can do it whatever way works for you:
# Say there are n chromosomes/scaffolds in the G2 assembly, so we will have G1.1.fa, G2.2.fa, ..., G2.n.fa.
# Split the G2 chromosomes/scaffolds into 3K chunks and make lift files
#mkdir lift
#mkdir split
#Change (1..19) to be the appropriate number of chromosomes/features
#for i in {1..19}
#do
#  ./tools/faSplit size ./Mcaroli_chr/Mcaroli_chr$i.fa  3000 ./split/Mcaroli.$i.split  -lift=./lift/Mcaroli.$i.lft -oneFile
#done
 
# run blat
#mkdir psl
#for i in {1..19}
#do
#  ./tools/blat mm10.fasta ./split/Mcaroli.$i.split.fa -t=dna -q=dna -tileSize=12 -fastMap -minIdentity=95 -noHead -minScore=100  ./psl/Mcaroli.$i.psl
#done
 
# Change coordinates of .psl files to parent coordinate system
#mkdir liftup
#for i in {1..19}
#do
#   ./tools/liftUp -pslQ ./liftup/Mcaroli.$i.liftup.psl ./lift/Mcaroli.$i.lft warn ./psl/Mcaroli.$i.psl
#done
 
# Make chain files
#mkdir chain_raw
#for i in {1..19}
#do
#    ./tools/axtChain -linearGap=medium  -faQ -faT -psl ./liftup/Mcaroli.$i.liftup.psl ./mm10.fasta ./Mcaroli_allchr.fasta ./chain_raw/$i.chain
#done
 
# Merge and sort chain files
#./tools/chainMergeSort ./chain_raw/*.chain | ./tools/chainSplit chain_split stdin
 
#./tools/faSize Mcaroli_allchr.fasta  -detailed >Mcaroli.chr_length.txt
#./tools/faSize mm10.fasta  -detailed >mm10.chr_length.txt
 
# Make alignment nets from chain files
mkdir net
for i in  ./chain_split/*.chain
do
 tag=${i/\.\/chain_split\//}
 ./tools/chainNet $i ./mm10.chr_length.txt ./Mcaroli.chr_length.txt ./net/$tag.net /dev/null
done
 
# Create liftOver chain file
mkdir over
for i in ./chain_split/*.chain
do
  tag=${i/\.\/chain_split\//}
  ./tools/netChainSubset  ./net/$tag.net $i ./over/$tag.chain
done
 
cat ./over/*.chain >mm10_Mcaroli.over.chain

# Make bed file to report converted coordinates. 
# The input MUST be a bed file, but you can convert a VCF file into a bed file to serve as a reference - let me know if you need a script for this
# We can give the coordinates of our query regions (based on G1 assembly) in the input.bed file and liftOver will report the converted coordinates in conversion.bed file.
#Unmapped are regions that don't get mapped
#Conversion is your coordinates output file
#
#change this (below) (!!)
./tools/liftOver ./43indiv_filter20_pos_only.bed ./mm10_Mcaroli.over.chain Mcaroli_mm10_liftover_20March2018.bed unMapped
