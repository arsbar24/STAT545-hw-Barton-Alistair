all: summary

download:
	Rscript MakeFiles/00_download.R
	
analyze: download MakeFiles/01_dataframe.R
	Rscript MakeFiles/01_dataframe.R
	
plot: analyze MakeFiles/02_plot.R
	Rscript MakeFiles/02_plot.R
	rm tweets.rda
	rm tweetdata.tsv
	mv *.tsv SummaryFiles
	mv tweet_freq.png SummaryFiles

summary: plot 03_summary.Rmd
	Rscript -e "rmarkdown::render('03_summary.Rmd')"
	rm 03_summary.html
	mv 03_summary.md ./Summary.md

clean:
	rm -f SummaryFiles/*
	rm -f Summary.md