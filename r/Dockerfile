FROM rocker/rstudio-stable:latest

RUN apt-get -y update
RUN apt-get -y install libpq-dev libxml2-dev texlive-full

RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('httr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RCurl', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RPostgreSQL', repos='http://cran.rstudio.com/')"

RUN echo "library(curl)" >> /home/rstudio/.Rprofile
RUN echo "library(httr)" >> /home/rstudio/.Rprofile
RUN echo "library(RPostgreSQL)" >> /home/rstudio/.Rprofile
RUN echo "library(RCurl)" >> /home/rstudio/.Rprofile

CMD ["/init"]
