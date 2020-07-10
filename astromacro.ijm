macro "Nuclear Quantification" {

    dirin = getDirectory("Choose input directory...");
    list = getFileList(dirin);
    run("Set Measurements...", "min integrated redirect=None decimal=3");

    setBatchMode(true);
    print("Number of files:" + list.length)

    for (n = 0; n<list.length; n++) {
        actualFolder = dirin + list[n];
        actualList = getFileList(actualFolder);
        
        //print("Ordner "+n + " -- " + actualFolder);
    
        k = 0;
        title = list[n];
        print(title + " scanning...");
        setResult(title + "Mean", 0, 0);
        updateResults();

        print("Test");
        for (i=0; i<actualList.length; i++) {
            
            roiManager("reset");
        
            //Astro
            open(actualFolder+actualList[i]);
            Astro = getTitle();
        
            //C3
            i++;
            i++;
            open(actualFolder+actualList[i]);
            C3 = getTitle();
        
            selectWindow(Astro);
            run("Subtract Background...", "rolling=50 sliding");
            setMinAndMax(50, 200);
            run("Apply LUT");
            run("Despeckle");
            run("Median...", "radius=2");
            run("k-means Clustering ...", "number_of_clusters=5 cluster_center_tolerance=0.00010000 enable_randomization_seed randomization_seed=48 show_clusters_as_centroid_value");
            setThreshold(120, 255);
            run("Convert to Mask");
            run("Analyze Particles...", "size=700-200000 circularity=0.0-1.00 exclude show=Nothing add");

    

            selectWindow(C3);
            //setMinAndMax(25, 255);
            //run("Apply LUT");
            roiManager("Show All without labels");
            //waitForUser("");

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
            //----------------------------------------------------------

            roiManager("Reset");
            run("Close All");
        }
    }
}