#Extract image metadata and create spreadsheet for camera trap files
#11/8/2018
#Chad Zirbel

#load packages
library(exifr) #This only works in R (not R studio right now)

#set working directory: location of the the images
setwd("D:/Bison_camera_trap_2018")

#pull metadata from photos
dat<-read_exif(list.files(),recursive=T,tags=c("Directory",
          "DateTimeOriginal","Sequence"))

#wire .csv file
#write.csv(dat,"bison_photo_metadata_2018.csv")

#read in data to work in Rstudio
photo_data<-read.csv("bison_photo_metadata_2018.csv",row.names = 1)

#remove plot info from SourceFile column
photo_data$SourceFile<-sapply(strsplit(as.character(photo_data$SourceFile),
                        split='/', fixed=TRUE), function(x) (x[2]))

#split date and time into two columns
photo_data$date<-format(as.POSIXct(photo_data$DateTimeOriginal,
                 format="%Y:%m:%d %H:%M:%S"),"%Y:%m:%d")

photo_data$time<-format(as.POSIXct(photo_data$DateTimeOriginal,
                 format="%Y:%m:%d %H:%M:%S"),"%H:%M:%S")
#remove combinded date time column
photo_data$DateTimeOriginal<-NULL

#write cleaned .csv file
write.csv(photo_data,"bison_image_datasheet_2018.csv")
