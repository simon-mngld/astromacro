// Settings
extension = ".tif";
showimages = true;      // display the images while the macro runs

print("\\Clear");

macro "Nuclear Quantification" {

    
    dirin = getDirectory("Choose input directory...");  // lets the user choose the upper folder containing subfolders containg acquisitions: /chosen-folder/folder/acquisition.czi
    start = getTime();
    list = getFileList(dirin);
    
    /*
    //--------------------------------------------
    // Extract wanted files into the "list array"
    
    tlist = newArray(100);
    temp = getFileList(dirin);
    
    c = -1;
    for (t=0;t<temp.length; t++) {
        
        if (indexOf(temp[t], extension, 0) > 0) {
            c++;
            tlist[c] = temp[t];
        } 
    }
    
    if (c==-1) {
        print ("No valid file found in: "+dirin);
        exit;
    }
    
    list = Array.slice(tlist,0,c+1);
    //--------------------------------------------
    */
    
    //Array.print(list);
    
    run("Set Measurements...", "min integrated redirect=None decimal=3");

    if (!showimages) setBatchMode(true);
    
    print("Number of files:" + list.length);

    for (n = 0; n<list.length; n++) {
        
        print(list[n]);
        
        k = 0;
        title = list[n];
        print(title + " scanning...");
        setResult(title + "Mean", 0, 0);
        updateResults();
        
        roiManager("reset");
        
        //open(list[n]);
        
        
        
        
        actualFolder = dirin + list[n];
        actualList = getFileList(actualFolder);
        
        
        
        print("Ordner "+n + " -- " + actualFolder);
    
        

        
        for (i=0; i<actualList.length; i++) {
            
            
        
            //Astro
            open(actualFolder+actualList[i]);
            Astro = getTitle();
            print(Astro);
            
            //C3
            //i++;
            i++;
            open(actualFolder+actualList[i]);
            C3 = getTitle();
            print(C3);
        
            selectWindow(Astro);
            run("Subtract Background...", "rolling=50 sliding");
            setMinAndMax(40, 200);
            run("Apply LUT");
            run("Despeckle");
            run("Median...", "radius=2");
            run("k-means Clustering ...", "number_of_clusters=3 cluster_center_tolerance=0.00010000 enable_randomization_seed randomization_seed=32 show_clusters_as_centroid_value");
            setThreshold(50, 255);
            run("Convert to Mask");
            run("Analyze Particles...", "size=600-200000 circularity=0.0-1.00 exclude show=Nothing add");

            selectWindow(Astro);
            //setMinAndMax(10, 255);
            //run("Apply LUT");
            roiManager("Show All without labels");
            if (showimages) waitForUser("Klicken, um fortzufuehren");

            run("Set Measurements...", "mean integrated redirect=None decimal=3");

            //----------------------------------------------------------
            for(j=0; j<roiManager("count"); j++) {

                roiManager("select", j);
                List.setMeasurements;
                mean = List.getValue("Mean");
    
                setResult(title + "Mean", k, mean);
                //setResult(title+"intensity", k, intensity);
                k++;
    
                updateResults();
                //IJ.deleteRows(nResults-roiManager("count"), nResults);
                updateResults();
            }
            //------------------------------------------------------

            
        }
        
        
        roiManager("Reset");
        run("Close All");
        

    }
    
    scripttime = (getTime() - start)/1000;
    print ("Script execution time: "+scripttime+"s");    
    
}

