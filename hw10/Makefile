all: scrape report

scrape: dataframing.R
	Rscript dataframing.R

report: 03_summary.Rmd
	Rscript -e "rmarkdown::render('03_summary.Rmd')"

clean:
	rm -f ScrapingBy.md
	rm -f ScrapingBy.html
	rm -f ScrapingBy_files
	rm -f rmp_data.csv