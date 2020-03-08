#!/usr/bin/perl 

#

#
# This script updates Artwork of every  mp3 file found in the given directory & subdirectories.
# It will remove exisiting Artowrk , populate background with background.png dile and annotate details
# with following information which is read from the ID3v2 tags of the file 
# Song Title , Movie name , Singer , Music , Lyricist , Year , Genre , Comment , Filename (generated)
#
#


@ARGV = qw(.) unless @ARGV;
use File::Find qw(finddepth);
use File::Basename;
use MP3::Tag;
use Image::Magick;
*name = *File::Find::name;
%MOVIE;
$bg_image='../background.png';

finddepth \&abcd, @ARGV;
sub abcd {
        if (-1 && -f) {
                if ($_ eq '.') {next;}
		if ($_ !~  /\.mp3/ && $_ !~  /\.MP3/ && $_ !~  /\.Mp3/ ) {next;}
	push(@FILES,$name);	
	}
}

foreach $filename (@FILES) {
	$filename=~s/\.\///;
	print "$filename:";
        if ( ! -f $filename ) {
                print "file $filename doesnt exists\n";
                return;
        }
        $mp3 = MP3::Tag->new($filename) || die "Failed open mp3 file $filename , $!\n";
        $mp3->get_tags();
      	if (exists $mp3->{ID3v2}) {
         	$id3v2 = $mp3->{ID3v2};
		&remove_artwork;
		&update_artwork_with_bgimage;
		$id3v2->write_tag();
        } else {
                print "\tNo ID3v2 tags for $filename\n";
        }

	$mp3->close();
	print "------------------------------------\n";
}

sub remove_artwork {
	 print "\n";
         $frameIDs_hash = $id3v2->get_frame_ids;
	        foreach my $frame (keys %$frameIDs_hash) {
			#print "$frame\n";
			if ($frame =~ /APIC/) {
				$id3v2->remove_frame($frame);
				#print "removed  : $frame\n";
			}
		}

}




sub update_artwork_with_bgimage {

         $frameIDs_hash = $id3v2->get_frame_ids;

	 $song=$id3v2->get_frame('TIT2');
	 $movie=$id3v2->get_frame('TALB');
	 $music=$id3v2->get_frame('TCOM');
	 $lyric=$id3v2->get_frame('TEXT');
	 $year=$id3v2->get_frame('TYER');
	 $singer=$id3v2->get_frame('TPE1');
	 $genre = $id3v2->get_frame('TCON');
	 $comments=$id3v2->frame_select('COMM', '', ['']);
	($file_basename,$file_path,$file_suffix) = fileparse($filename);

	$APIC="Song  : " . $song . "\nMovie : " . $movie . "\nSinger: " . $singer . "\nMusic : " . $music . "\nLyrics : " . $lyric . "\nYear   : " . $year;
	$APIC=$APIC .  "\n\nGenre : " . $genre . "\nGroup : " . $comments . "\nFile     : " . $file_basename;

	#print "$APIC \n";

        $image = Image::Magick->new;
	if ( ! -f $bg_image) {die "Cant find $bg_image\n";}
	$x = $image->Read($bg_image);		
	warn "$x" if "$x";
	$x = $image->Crop(geometry=>'500x500');
	warn "$x" if "$x";


        $image->Annotate(font=>'Courier.ttf', pointsize=>28, fill=>'white', text=>$APIC, x=>10, y=> 145);
        $imagedata = $image->ImageToBlob(magick => jpg);
        $mp3 = MP3::Tag->new($filename) || die "Failed open mp3 file $filename , $!\n";
	$id3v2->add_frame("APIC", 0, "image/jpg", "\x00", "", $imagedata);

}

