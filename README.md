# MP3 ID3 Tag Tools
Collection of Perl tools for reading and updating MP3 ID3v2 tags in a programmatic way. These scripts are heavily useful
if you have requirement to update ID3 tags of multiple MP3 files.

## Pre-requisites : Following perl modules are required

* File::Find
* File::Basename
* MP3::Tag
* Image::Magick

----

## [Print ID3V2 tags](../master/Scripts/print_mp3_id3v2_tags_use_find.pl)
This script prints following ID3V2 tags of every MP3 file found in the given directory & its subdirectories in horizondal line format. Output generated by this can be used for multiple purposes like data search , input to other scripts etc. 

* Song Title
* Album Name
* Composer
* Lyricst
* Year
* Artist
* Genre
* Comment

Output filds are colon separated in the following order.

FileName:SongTitle:AlbumName:Composer:Lyricst:Year:Artist:Genre:Comment

__Usage__
* $ ./print_mp3_id3v2_tags_use_find.pl  "directory to scan for MP3 files"
  
__A sample output will look like below__

###### MAIE.mp3:manasse santhamakoo:Aalilakkuruvikal:Mohan Sitara:Bichu Thirumala:1988:Venugopal G:(24):Malayalam
###### MELA.mp3:poothalam(m):Kalikalam:Johnson:Kaithapram:1990:Venugopal G:(24):Malayalam
######  MEPZ.mp3:Unarumee Gaanam:Moonam Pakkam:Ilayaraja:Sreekumaran Thampi:1988:Venugopal G:(24):Malayalam
###### MEUU.mp3:etho vaarmukilin:Pookkalam Varavayi:Ouseppachan:Bichu Thirumala,Kaithapr...:1991:Venugopal G:(24):Malayalam
###### OBMV.mp3:mookilla rajyathe:Sambhavami Yuge Yuge:Baburaj MS:Sreekumaran Thampi:1972:Yesudas,Vasantha B:(24):Malayalam
###### OBTV.mp3:Oru kotta ponnundallo:Kuttikkuppayam:Baburaj MS:Bhaskaran P:1964:Eswari LR:(24):Malayalam

Please note that FileName (eg OBTV.mp3) printed in the ouput doesnt include it's path name.

----

## [Update ID3V2 tags](../master/Scripts/update_mp3_tags_use_find.pl)
This script reads following information  from the data source file "songs_data.csv" and populate same on all mp3 files in the given directory & subdirectories . 
* Song Title
* Album Name
* Composer
* Lyricst
* Year
* Artist
* Genre (numberic number)
* Comment

Script expects one entry in  "songs_data.csv" for every MP3 file found in the scan, information should be colon separated in the following order.

SongTitle:AlbumName:Composer:Lyricst:Year:Artist:Genre:Comment

__A sample input file  will look like below__

###### MELA.mp3:poothalam(m):Kalikalam:Johnson:Kaithapram:1990:Venugopal G:(24):Malayalam
###### MEPZ.mp3:Unarumee Gaanam:Moonam Pakkam:Ilayaraja:Sreekumaran Thampi:1988:Venugopal G:(24):Malayalam
###### OBTV.mp3:Oru kotta ponnundallo:Kuttikkuppayam:Baburaj MS:Bhaskaran P:1964:Eswari LR:(24):Malayalam

Please note that FileName (eg OBTV.mp3) in the inpiut files doesnt include it's path name.

__Usage__
* $ ./update_mp3_tags_use_find.pl "directory to scan for MP3 files"

----
