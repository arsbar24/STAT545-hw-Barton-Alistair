all: summary

tweets.rda:
	Rscript 00_download.R
	
analyze: tweets.rda 01_dataframe.R
	Rscript 01_dataframe.R
	
plot: analyze 02_plot.R
	Rscript 02_plot.R
	rm tweets.rda

summary: Summary.Rmd plot
	Rscript -e "rmarkdown::render('Summary.Rmd')"
	rm Summary.html
	rm tweetdata.tsv

clean:
	rm -f tweetdata.rda
	rm -f tweet_freq.png
	rm -f Words.tsv
	rm -f Occ.csv