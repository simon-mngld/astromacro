        roiManager("reset");
        Astro = getTitle();
run("Duplicate...", " ");

            run("Subtract Background...", "rolling=50 sliding");
            setMinAndMax(20, 255);
            run("Apply LUT");
            run("Despeckle");
            run("Median...", "radius=2");
            run("k-means Clustering ...", "number_of_clusters=7 cluster_center_tolerance=1000 enable_randomization_seed randomization_seed=1000 show_clusters_as_centroid_value");
            setThreshold(30, 255);
            run("Convert to Mask");
run("Analyze Particles...", "size=300-70000 circularity=0.0-1.00 show=Nothing add");

           
            selectWindow(Astro);
roiManager("Show All without labels");

