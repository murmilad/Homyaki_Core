package Homyaki::Imager;

use Imager;

use constant ORIENTATIONS => {
	6 => 90,
	8 => 270
};

sub put_watermark {
	my $img             = shift;
	my $watermark_image = shift;

	my $w  = $img->getwidth();
	my $h  = $img->getheight();

	my $pic = $img->filter(
		type    => "watermark",
		tx      => $w - $watermark_image->getwidth(),
		ty      => $h - $watermark_image->getheight(),
		wmark   => $watermark_image,
		pixdiff => 20
	) or die $img->errstr;

	return $img;
}

sub change_size {
	my $img  = shift;
	my $size = shift;

	my $w  = $img->getwidth();
	my $h  = $img->getheight();
	my $s;
	my $s  = $size / (($w < $h) ? $w : $h);
	$s = 1 if $s > 1;
	my $sw = $w * $s;
	my $sh = $h * $s;

	Homyaki::Logger::print_log("Build_Gallery: change_size Scalefactor: $s");
	print "\tScalefactor: $s\n\n";

	my $pic = $img->scale(scalefactor => $s);

	return $pic;
}

sub rotate {
	my $img = shift;

	my @tags = $img->tags();
	my $orientation = get_tag_data(\@tags, 'exif_orientation');
	my $grad = &ORIENTATIONS->{$orientation};

	my $pic;

	if ($grad){
		Homyaki::Logger::print_log("Build_Gallery: rotate: Rotate $grad");
		print "Rotate $grad\n";
		$pic = $img->rotate(right => $grad);
	} else {
		$pic = $img;
	}

	return $pic
}

sub get_tag_data {
	my $tags     = shift;
	my $tag_name = shift;

	return unless $tags;

	foreach (@{$tags}){
		return $_->[1] if $_->[0] eq $tag_name
	}
}
1;
