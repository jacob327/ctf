Q10.[Forensics] River
---------------------

問題
----
```
10pt

JPEGという画像ファイルのフォーマットでは、撮影時の日時、使われたカメラ、位置情報など様々な情報(Exif情報)が付加されることがあるらしい。
この情報から、写真に写っている川の名前を特定して欲しい。
問題ファイル： river.jpg

FLAGの形式は、"cpaw{river_name}"
例：隅田川 → cpaw{sumidagawa}
----------------------
```

解き方
-----

フォレンジック問題です。

まずはファイルの種類を特定します。

```
$ file river.jpg
river.jpg: JPEG image data, JFIF standard 1.01, resolution (DPI), density 72x72, segment length 16, Exif Standard: [TIFF image data, big-endian, direntries=10, manufacturer=Sony, model=SO-01G, orientation=upper-left, xresolution=148, yresolution=156, resolutionunit=2, software=23.1.B.1.160_6_f1000010, datetime=2015:09:14 12:50:38, GPS-Data], baseline, precision 8, 3840x2160, components 3
```

確かにjpgのようです。

jpgやmp3などのメディアファイルにはメタ情報も格納されています。

今回は川の名前が欲しいので、メタ情報に格納されていないか確認します。

```
$ exiftool river.jpg 
ExifTool Version Number         : 11.16
File Name                       : river.jpg
Directory                       : .
File Size                       : 414 kB
File Modification Date/Time     : 2019:12:06 19:15:54+09:00
File Access Date/Time           : 2019:12:09 14:49:12+09:00
File Inode Change Date/Time     : 2019:12:06 19:16:01+09:00
File Permissions                : rw-r--r--
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg
JFIF Version                    : 1.01
Exif Byte Order                 : Big-endian (Motorola, MM)
Make                            : Sony
Camera Model Name               : SO-01G
Orientation                     : Horizontal (normal)
X Resolution                    : 72
Y Resolution                    : 72
Resolution Unit                 : inches
Software                        : 23.1.B.1.160_6_f1000010
Modify Date                     : 2015:09:14 12:50:38
Exposure Time                   : 1/2000
F Number                        : 2.0
ISO                             : 50
Exif Version                    : 0220
Date/Time Original              : 2015:09:14 12:50:38
Create Date                     : 2015:09:14 12:50:38
Components Configuration        : Y, Cb, Cr, -
Shutter Speed Value             : 1/1992
Exposure Compensation           : 0
Metering Mode                   : Multi-segment
Light Source                    : Unknown
Flash                           : Off, Did not fire
Focal Length                    : 4.6 mm
Sub Sec Time                    : 190234
Sub Sec Time Original           : 190234
Sub Sec Time Digitized          : 190234
Flashpix Version                : 0100
Color Space                     : sRGB
Exif Image Width                : 3840
Exif Image Height               : 2160
Custom Rendered                 : Normal
Exposure Mode                   : Auto
White Balance                   : Auto
Digital Zoom Ratio              : 1
Scene Capture Type              : Landscape
Subject Distance Range          : Unknown
GPS Version ID                  : 2.3.0.0
GPS Latitude Ref                : North
GPS Longitude Ref               : East
XMP Toolkit                     : XMP Core 5.4.0
Creator Tool                    : 23.1.B.1.160_6_f1000010
Current IPTC Digest             : d5bc65b4a8aa881aa3cbcb4c82d92707
Coded Character Set             : UTF8
Application Record Version      : 2
Digital Creation Time           : 12:50:38
Digital Creation Date           : 2015:09:14
Date Created                    : 2015:09:14
Time Created                    : 12:50:38
IPTC Digest                     : d5bc65b4a8aa881aa3cbcb4c82d92707
Profile CMM Type                : Linotronic
Profile Version                 : 2.1.0
Profile Class                   : Display Device Profile
Color Space Data                : RGB
Profile Connection Space        : XYZ
Profile Date Time               : 1998:02:09 06:49:00
Profile File Signature          : acsp
Primary Platform                : Microsoft Corporation
CMM Flags                       : Not Embedded, Independent
Device Manufacturer             : Hewlett-Packard
Device Model                    : sRGB
Device Attributes               : Reflective, Glossy, Positive, Color
Rendering Intent                : Perceptual
Connection Space Illuminant     : 0.9642 1 0.82491
Profile Creator                 : Hewlett-Packard
Profile ID                      : 0
Profile Copyright               : Copyright (c) 1998 Hewlett-Packard Company
Profile Description             : sRGB IEC61966-2.1
Media White Point               : 0.95045 1 1.08905
Media Black Point               : 0 0 0
Red Matrix Column               : 0.43607 0.22249 0.01392
Green Matrix Column             : 0.38515 0.71687 0.09708
Blue Matrix Column              : 0.14307 0.06061 0.7141
Device Mfg Desc                 : IEC http://www.iec.ch
Device Model Desc               : IEC 61966-2.1 Default RGB colour space - sRGB
Viewing Cond Desc               : Reference Viewing Condition in IEC61966-2.1
Viewing Cond Illuminant         : 19.6445 20.3718 16.8089
Viewing Cond Surround           : 3.92889 4.07439 3.36179
Viewing Cond Illuminant Type    : D50
Luminance                       : 76.03647 80 87.12462
Measurement Observer            : CIE 1931
Measurement Backing             : 0 0 0
Measurement Geometry            : Unknown
Measurement Flare               : 0.999%
Measurement Illuminant          : D65
Technology                      : Cathode Ray Tube Display
Red Tone Reproduction Curve     : (Binary data 2060 bytes, use -b option to extract)
Green Tone Reproduction Curve   : (Binary data 2060 bytes, use -b option to extract)
Blue Tone Reproduction Curve    : (Binary data 2060 bytes, use -b option to extract)
Image Width                     : 3840
Image Height                    : 2160
Encoding Process                : Baseline DCT, Huffman coding
Bits Per Sample                 : 8
Color Components                : 3
Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
Aperture                        : 2.0
Date/Time Created               : 2015:09:14 12:50:38
Digital Creation Date/Time      : 2015:09:14 12:50:38
GPS Latitude                    : 31 deg 35' 2.76" N
GPS Longitude                   : 130 deg 32' 51.73" E
GPS Position                    : 31 deg 35' 2.76" N, 130 deg 32' 51.73" E
Image Size                      : 3840x2160
Megapixels                      : 8.3
Shutter Speed                   : 1/2000
Create Date                     : 2015:09:14 12:50:38.190234
Date/Time Original              : 2015:09:14 12:50:38.190234
Modify Date                     : 2015:09:14 12:50:38.190234
Focal Length                    : 4.6 mm
Light Value                     : 14.0
```

コメント等に特に情報はないですが、GPS情報がありました。

```
GPS Latitude                    : 31 deg 35' 2.76" N
GPS Longitude                   : 130 deg 32' 51.73" E
```

この位置情報をググって川の名前をローマ字にすれば良いです。

FLAG
-----
`cpaw{koutsukigawa}`

甲突川 をローマ字にするとkotsukiになるように思って時間がかかりました。。

答えを一意にできないのは、問題が良くないかもと思いました。

