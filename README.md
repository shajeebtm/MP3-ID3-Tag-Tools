# MP3 ID3 Tag Tools
Collection of Perl tools for reading and updating MP3 ID3v2 tags in a programmatic way. These scripts are heavily useful
if you have requirement to update ID3 tags of multiple MP3 files.

## Pre-requisites : Following perl modules are required

* File::Find
* File::Basename
* MP3::Tag
* Image::Magick

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
