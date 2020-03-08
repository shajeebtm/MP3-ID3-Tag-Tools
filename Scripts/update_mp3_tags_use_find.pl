#!/usr/bin/perl 

# This script reads following information  from the file songs_data.csv and populate same on all mp3 files in the given directory & subdirectories
# FileName:SongTitle:AlbumName:Composer:Lyricst:Year:Artist:Genre:Comment

$master_data='songs_data.csv';

@ARGV = qw(.) unless @ARGV;
use File::Find qw(finddepth);
use File::Basename;
use MP3::Tag;
*name = *File::Find::name;
%MOVIE;

# Read content of Databse file and populate into a hash
open(FILE,$master_data) || die "Unable to open file $master_data, $!";
while ($line=<FILE>) {
	chomp $line;

	($filename,$song,$movie,$music,$lyric,$year,$singer,$genre,$comment)=split(/:/,$line);
	chomp ($song,$movie,$lyric,$music,$year,$singer,$genre,$comment);
	if (exists $MOVIE{$file} ) {
		print "Duplicate entry of  $filename found in DB $master_data\n";
		exit;
	}
	$MOVIE{$filename}=$line;

}
close FILE;

finddepth \&abcd, @ARGV;	# Create a list of al MP3 files
sub abcd {
        if (-1 && -f) {
                if ($_ eq '.') {next;}
		if ($_ =~  /\.mp3/i  ) {
			$name =~ s/\.\///;
			 print "$name\n";
			push(@FILES,$name);
		}
		if ($_ !~  /\.mp3/i ) {next;}
	}
}


#This loop is for dry run to check if every mp3 file has an entry in the Database
foreach $filename (@FILES) {
	print "Checking $filename : \n";
	($file_basename,$file_path,$file_suffix) = fileparse($filename);
	if (exists $MOVIE{$file_basename} ) {
		print "OK\n";
	} else {
		print "no DB entry for song $filename\n";
		print "please fix it to proceed further\n";
		exit;
	}
}


#This loop is for actual action
print "\n\nACTUAL WORK STARTS HERE \n\n";
foreach $filename (@FILES) {
	($file_basename,$file_path,$file_suffix) = fileparse($filename);
	if (exists $MOVIE{$file_basename} ) {
		($file,$song,$movie,$music,$lyric,$year,$singer,$genre,$comment)=split(/:/,$MOVIE{$file_basename});

		&set_id3v1;		# Update ID3v1 tags
		&set_id3v2;		# Will remove ID3v2 tags and update with the information in the Database
		print "$filename : DONE\n";
	} else {
		print "no DB entry for song $filename\n";
	}
}



sub set_id3v1 {
        if ( ! -f $filename ) {
                print "file $filename doesnt exists\n";
                return;
        }

        $mp3 = MP3::Tag->new($filename) || die "Failed open mp3 file $filename , $!\n";
        if (exists $mp3->{ID3v1} ) {
                $id3v1 = $mp3->{ID3v1};
        } else {
                $id3v1 = $mp3->new_tag("ID3v1");
        }
             $id3v1->title($song);
             $id3v1->artist($singer);
             $id3v1->album($movie);
             $id3v1->year($year);
             $id3v1->comment($comment);
             $id3v1->genre($genre);

        $id3v1->write_tag();
        $mp3->close();
}





sub set_id3v2 {
        if ( ! -f $filename ) {
                print "file $filename doesnt exists\n";
                return;
        }
	$TPE1=$singer;
	$TPE2=$lyric;
	$TYER=$year;
	$TALB=$movie;
	$TIT2=$song;
	$TCOM=$music;
	$TEXT=$lyric;
	$TCON=$genre;
        $COMM=$comment;


        $mp3 = MP3::Tag->new($filename) || die "Failed open mp3 file $filename , $!\n";
	if (exists $mp3->{ID3v2} ) {
		$id3v2->remove_tag();
		#$id3v2 = $mp3->{ID3v2};
	} else {
		$id3v2 = $mp3->new_tag("ID3v2");
	}

	$id3v2->add_frame("TPE1",$TPE1);
	$id3v2->add_frame("TPE2",$TPE2);
	$id3v2->add_frame("TYER",$TYER);
	$id3v2->add_frame("TALB",$TALB);
	$id3v2->add_frame("TIT2",$TIT2);
	$id3v2->add_frame("TCOM",$TCOM);
	$id3v2->add_frame("TEXT",$TEXT);
	$id3v2->add_frame("TCON",$TCON);
        $id3v2->add_frame("COMM","ENG","",$COMM);

	$id3v2->write_tag();	
	$mp3->close();
}

