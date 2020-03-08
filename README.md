# MP3 ID3 Tag Tools
Collection of Perl tools for reading and updating MP3 ID3v2 tags in a programmatic way. These scripts are heavily useful
if you have requirement to update ID3 tags of multiple MP3 files.

## Pre-requisites : Following perl modules are required

* File::Find
* File::Basename
* MP3::Tag
* Image::Magick

----
## Print ID3V2 tags
This script prints following ID3V2 tags of every MP3 file found in the given directory & its subdirectories.

* Song Title
* Album Name
* Composer
* Lyricst
* Year
* Artist
* Genre
* Comment

Output filds are colon separated in following order

SongTitle:AlbumName:Composer:Lyricst:Year:Artist:Genre:Comment

__A sample output will look like below__

###### MAIE.mp3:manasse santhamakoo:Aalilakkuruvikal:Mohan Sitara:Bichu Thirumala:1988:Venugopal G:(24):Malayalam
###### MELA.mp3:poothalam(m):Kalikalam:Johnson:Kaithapram:1990:Venugopal G:(24):Malayalam
######  MEPZ.mp3:Unarumee Gaanam:Moonam Pakkam:Ilayaraja:Sreekumaran Thampi:1988:Venugopal G:(24):Malayalam
###### MEUU.mp3:etho vaarmukilin:Pookkalam Varavayi:Ouseppachan:Bichu Thirumala,Kaithapr...:1991:Venugopal G:(24):Malayalam
###### OBMV.mp3:mookilla rajyathe:Sambhavami Yuge Yuge:Baburaj MS:Sreekumaran Thampi:1972:Yesudas,Vasantha B:(24):Malayalam
###### OBTV.mp3:Oru kotta ponnundallo:Kuttikkuppayam:Baburaj MS:Bhaskaran P:1964:Eswari LR:(24):Malayalam


----
