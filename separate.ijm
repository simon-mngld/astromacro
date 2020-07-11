// Separate Layers and Channels of images
requires("1.52s");

// Set your image file type here
filetype = ".czi";

print("\\Clear");

setBatchMode(true);
MainDir = getDirectory("Choose starting directory...");
checkFiles(MainDir);


function checkFiles(dir) {
    list = getFileList(dir);
    for (i=0; i<list.length; i++) {
        if (endsWith(list[i], "/")) {
            checkFiles(""+dir+list[i]);
        } else {
            if (endsWith(list[i], filetype)) {
                open(dir + list[i]);
                split();
                run("Close All");
            } else {
                //print("NO IMAGE: " + dir + list[i]);
                //print("---------------------------------------");
            }
        }
    }
}


function split(){

    ImageTitle = getTitle();
    ImageDir = getInfo("image.directory"); // Directory of the current image

    getDimensions(w,h,channels,slices,f);
    print("Channels: "+channels+"  Slices: "+slices);

    print ("ImageDir: "+ImageDir);
    print ("ImageTitle: "+ImageTitle);

    if (channels+slices > 2) {
        File.makeDirectory(ImageDir+ImageTitle+"#");
        saveDir = ImageDir+ImageTitle+"#/";

        File.setDefaultDir(saveDir);

        run("Image Sequence... ", "format=TIFF digits=2 name=img");

        images = getFileList(saveDir);
        
        //print("SaveDir: "+saveDir);
        
        if (slices>1) {
            for (i=0;i<images.length;i++) {
                tempdir = substring(images[i],0,7);
                File.makeDirectory(saveDir+tempdir);
                File.copy(saveDir+images[i],saveDir+tempdir+"/"+images[i]);
                t = File.delete(saveDir+images[i]);
            }
        }
        
    } else {
        print("File does not contain layers: No operation performed.");
    }

    print("---------------------------------------");
}

print("Finished.");
