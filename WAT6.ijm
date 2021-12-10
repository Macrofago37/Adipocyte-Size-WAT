setBatchMode(true);
run("Set Measurements...", "area area_fraction display add redirect=None decimal=2");
run("Colors...", "foreground=white background=black selection=magenta");
id = getImageID(); 
title = getTitle(); 
path= getInfo("image.directory");
name=getInfo("image.filename");
run("8-bit");
run("Replace value", "pattern=0 replacement=255");
getLocationAndSize(locX, locY, sizeW, sizeH); 
width = getWidth(); 
height = getHeight(); 
tileWidth = width / 6; 
tileHeight = height / 6; 
for (y = 0; y < 6; y++) { 
offsetY = y * height / 6; 
 for (x = 0; x < 6; x++) { 
offsetX = x * width / 6; 
selectImage(id); 
 call("ij.gui.ImageWindow.setNextLocation", locX + offsetX, locY + offsetY); 
tileTitle = title + " [" + x + "," + y + "]"; 
 run("Duplicate...", "title=" + tileTitle); 
makeRectangle(offsetX, offsetY, tileWidth, tileHeight); 
 run("Crop"); 
} 
} 
selectImage(id); 
close(); 
run("Images to Stack", "name=Stack title=[] use");
run("Convert to Mask", "method=Mean background=Dark calculate");
run("Despeckle", "stack");
run("Close-", "stack");
for (i = 0; i < 3; i++) {
run("Dilate", "stack");
}
run("Close-", "stack");
run("Make Montage...", "columns=6 rows=6 scale=0.25");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Invert");
run("Median...", "radius=.1");
close("\\Others");
run("Scale...", "x=- y=- width=width height=height interpolation=Bilinear average create");
run("Convert to Mask");
run("Invert");
setBatchMode(false);
segment=getImageID();
open(path+name);
og=getImageID();
selectImage(segment);
run("Adjustable Watershed");
setBatchMode(true);
run("Create Selection");
roiManager("Add");
selectImage(og);
roiManager("Show All");
run("Tile");
selectImage(segment);
run("Select None");
run("Synchronize Windows");
setTool(18);
run("Pencil Tool Options...", "pencil=6.12");
selectWindow("Synchronize Windows");
waitForUser("Clicar em Syncrhonize All", "Corrigir a imagem com o pincel");
setBatchMode(true);
selectImage(segment);
close("\\Others");
run("Convert to Mask");
run("Invert");
run("Analyze Particles...", "  show=Overlay display exclude clear");
rename(replace(title, ".tif", "_Analyzed"));
setBatchMode(false);

