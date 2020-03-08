#!/usr/bin/perl 

# This script prints following ID3V2 tags of every MP3 file found in the given directory & subdirectories
# SongTitle:AlbumName:Composer:Lyricst:Year:Artist:Genre:Comment

@ARGV = qw(.) unless @ARGV;
use File::Find qw(finddepth);
use File::Basename;
use MP3::Tag;
*name = *File::Find::name;
%MOVIE;

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
	($file_basename,$file_path,$file_suffix) = fileparse($filename);
	#print "$filename:";		# if want the filenae inclduing  path
	print "$file_basename:";	# to print only filename
        if ( ! -f $filename ) {
                print "file $filename doesnt exists\n";
                return;
        }
        $mp3 = MP3::Tag->new($filename) || die "Failed to open mp3 file $filename , $!\n";
        $mp3->get_tags();
	&print_id3v2;
	$mp3->close();
}



sub print_id3v2 {
	
        if (exists $mp3->{ID3v2}) {
         $id3v2 = $mp3->{ID3v2};
         $frameIDs_hash = $id3v2->get_frame_ids;

	 print $id3v2->get_frame('TIT2') . ":";
	 print $id3v2->get_frame('TALB') . ":";
	 print $id3v2->get_frame('TCOM') . ":";
	 print $id3v2->get_frame('TEXT') . ":";
	 print $id3v2->get_frame('TYER') . ":";
	 print $id3v2->get_frame('TPE1') . ":";
	 $genre = $id3v2->get_frame('TCON','raw');
	 $genre =~ s/[[:^print:]\s]//g ;  # remove null character
	 print $genre . ":";
	 print $id3v2->frame_select('COMM', '', ['']) . "\n";
	}
}



