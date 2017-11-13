all: summary

tweets.rda:
	Rscript MakeFiles/00_download.R
	
analyze: tweets.rda MakeFiles/01_dataframe.R
	Rscript MakeFiles/01_dataframe.R
	
plot: analyze MakeFiles/02_plot.R
	Rscript MakeFiles/02_plot.R
	rm tweets.rda
	mv *.tsv SummaryFiles
	mv tweet_freq.png SummaryFiles

summary: plot MakeFiles/03_summary.Rmd
	Rscript -e "rmarkdown::render('MakeFiles/03_summary.Rmd')"
	rm MakeFiles/03_summary.html
	rm SummaryFiles/tweetdata.tsv
	mv MakeFiles/03_summary.md ./Summary.md

clean:
	rm -f SummaryFiles/*
	rm -f Summary.md