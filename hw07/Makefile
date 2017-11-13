all: plot.rda

tweets.rda:
	Rscript 00_download.R
	
analyzedata.rda: tweets.rda 01_dataframe.R
	Rscript 01_dataframe.R
	
plot: analyzedata.rda 02_plot.R
	Rscript 02_plot.R
	rm tweets.rda

summary: Summary.Rmd plot
	Rscript -e "rmarkdown::render('$<')"
	rm Summary.html
	rm tweetdata.tsv

clean:
	rm -f tweetdata.rda
	rm -f tweet_freq.png
	rm -f Words.csv