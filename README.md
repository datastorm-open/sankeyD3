# sankeyD3 - Sankey Network Graphs in R and Shiny

sankeyD3 v0.3 [![Build Status](https://travis-ci.org/fbreitwieser/sankeyD3.svg?branch=master)](https://travis-ci.org/fbreitwieser/sankeyD3). 
Based on [networkD3](https://github.com/christophergandrud/networkD3) and [d3-sankey](https://github.com/d3/d3-sankey).  

![image](https://cloud.githubusercontent.com/assets/516060/19978179/631e15e0-a1cc-11e6-8125-3f342c4f3b92.png)

## Installation and Usage

```R
# Installation
# install.packages('devtools')
devtools::install_github("datastorm-open/sankeyD3")

# Run example site directly from Github
shiny::runGitHub("datastorm/sankeyD3", subdir="inst/examples/shiny")

## Run it locally
library(sankeyD3)
# Based on http://bost.ocks.org/mike/sankey/
# Load energy projection data
URL <- paste0("https://cdn.rawgit.com/christophergandrud/networkD3/",
              "master/JSONdata/energy.json")
Energy <- jsonlite::fromJSON(URL)

# Plot
sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             units = "TWh", fontSize = 12, nodeWidth = 30)
```

### Saving to an external file

Use `saveNetwork` to save a network to stand alone HTML file:

```R
library(magrittr)

sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             units = "TWh", fontSize = 12, nodeWidth = 30) %>% saveNetwork(file = 'Net1.html')
```

## Features
 - Uses D3 v4
     - adds several modifications from networkD3 sankey.js 
     - includes fixes and features from unmerged pull requests:
       - d3/d3-plugins#124: Fix nodesByBreadth to have proper ordering
       - d3/d3-plugins#120: Added 'l-bezier' link type
       - d3/d3-plugins#36: Added 'path1' link type
       - d3/d3-plugins#40: Added 'path2' link type
       - d3/d3-plugins#74: Sort sankey target links by descending slope
       - d3/d3-sankey#4: Add horizontal alignment option to Sankey layout
 - Adds option numberFormat, default being ",.5g" (see , fixes christophergandrud/networkD3#147)
 - Adds option NodePosX, fixes christophergandrud/networkD3#108 
 - Adds option to force node ordering to be alphabetical along a path (only works well with trees with one parent for each node, but might fix christophergandrud/networkD3#153)
 - Zooming
 - Dragging both horizontally and vertically
 - Adds option showNodeValues to show node values above nodes
 - Adds option nodeCornerRadius for rounded nodes
 - Adds option title for titles in the upper-right corner of the plot
 - Adds <sankey id>_hover event that is fired every second
 - Adds option doubleclickTogglesChildren to hide children/downstram
    nodes
 - Adds option xScalingFactor to scale width between nodes
 - Adds option xAxisDomain to make an x-axis
 - Added option linkGradient to make link a gradient (when LinkGroup is not defined)
 - Added option linkColor to specify link color
 - Added option linkOpacity to specify opacity of link
 - Added option nodeShadow to add drop shadow
 - Added option nodeLabelMargin to specify the distance between label and node

