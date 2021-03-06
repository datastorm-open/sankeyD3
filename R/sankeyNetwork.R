#' Tools for Creating D3 Sankey Graphs from R
#'
#' Creates D3 JavaScript Sankey graphs from R. Based on networkD3.
#'
#' @name sankeyD3-package
#' @aliases sankeyD3
#' @docType package
NULL


#' Shiny bindings for sankeyD3 widgets
#'
#' Output and render functions for using sankeyD3 widgets within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended.
#' @param expr An expression that generates a sankeyD3 graph
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @importFrom htmlwidgets shinyRenderWidget
#'
#' @name sankeyD3-shiny
NULL

#' Create a D3 JavaScript Sankey diagram
#'
#' @param Links a data frame object with the links between the nodes. It should
#' have include the \code{Source} and \code{Target} for each link. An optional
#' \code{Value} variable can be included to specify how close the nodes are to
#' one another.
#' @param Nodes a data frame containing the node id and properties of the nodes.
#' If no ID is specified then the nodes must be in the same order as the
#' \code{Source} variable column in the \code{Links} data frame. Currently only
#' grouping variable is allowed.
#' @param Source character string naming the network source variable in the
#' \code{Links} data frame.
#' @param Target character string naming the network target variable in the
#' \code{Links} data frame.
#' @param Value character string naming the variable in the \code{Links} data
#' frame for how far away the nodes are from one another.
#' @param NodeID character string specifying the node IDs in the \code{Nodes}.
#' data frame. Must be 0-indexed.
#' @param NodeGroup character string specifying the node groups in the
#' \code{Nodes}. Used to color the nodes in the network.
#' @param labelValue \code{Value} is used to defined size. \code{labelValue} can be
#' used to print another value in tooltip
#' @param LinkGroup character string specifying the groups in the
#' \code{Links}. Used to color the links in the network.
#' @param NodePosX character specifying a column in the \code{Nodes} data
#' frame that specifies the 0-based ordering of the nodes along the x-axis.
#' @param NodeValue character specifying a column in the \code{Nodes} data
#' frame with the value/size of each node. If \code{NULL}, the value is 
#' calculated based on the maximum of the sum of incoming and outoging 
#' links
#' @param NodeColor character specifying a column in the \code{Nodes} data
#' frame with the color of each node. Overrides colourScale.
#' @param NodeFontColor character specifying a column in the \code{Nodes} data
#' frame with the color of the label of each node.
#' @param NodeFontSize character specifying a column in the \code{Nodes} data
#' frame with the size of the label of each node.
#' @param units character string describing physical units (if any) for Value
#' @param colourScale character string specifying the categorical colour
#' scale for the nodes. See
#' \url{https://github.com/mbostock/d3/wiki/Ordinal-Scales}.
#' @param fontSize numeric font size in pixels for the node text labels.
#' @param fontFamily font family for the node text labels.
#' @param fontColor font color for the node text labels.
#' @param nodeWidth numeric width of each node.
#' @param nodePadding numeric essentially influences the width height.
#' @param nodeStrokeWidth numeric width of the stroke around nodes.
#' @param nodeCornerRadius numeric Radius for rounded nodes.
#' @param numberFormat number format in toolstips - see https://github.com/d3/d3-format for options.
#' @param margin an integer or a named \code{list}/\code{vector} of integers
#' for the plot margins. If using a named \code{list}/\code{vector},
#' the positions \code{top}, \code{right}, \code{bottom}, \code{left}
#' are valid.  If a single integer is provided, then the value will be
#' assigned to the right margin. Set the margin appropriately
#' to accomodate long text labels.
#' @param height numeric height for the network graph's frame area in pixels.
#' @param width numeric width for the network graph's frame area in pixels.
#' @param title character Title of plot, put in the upper-left corner of the Sankey 
#' @param iterations numeric. Number of iterations in the diagramm layout for 
#' computation of the depth (y-position) of each node. Note: this runs in the 
#' browser on the client so don't push it too high.
#' @param align character Alignment of the nodes. One of 'right', 'left', 'justify', 'center', 'none'.
#' If 'none', then the labels of the nodes are always to the right of the node.
#' @param zoom logical value to enable (\code{TRUE}) or disable (\code{FALSE})
#' zooming
#' @param nodeLabelMargin numeric margin between node and label.
#' @param linkColor numeric Color of links.
#' @param linkOpacity numeric Opacity of links.
#' @param linkOpacityHover numeric Opacity of links when hover.
#' @param linkGradient boolean Add a gradient to the links?
#' @param dragX boolean Allow moving nodes along the x-axis?
#' @param dragY boolean Allow moving nodes along the y-axis?
#' @param nodeShadow boolean Add a shadow to the nodes?
#' @param xScalingFactor numeric Scale the computed x position of the nodes by this value.
#' @param xAxisDomain character[] If xAxisDomain is given, an axis with those value is 
#' added to the bottom of the plot. Only sensible when also NodeXPos are given.
#' @param linkType character One of 'bezier', 'l-bezier', 'trapezoid', 'path1' and 'path2'.
#' @param orderByPath boolean Order the nodes vertically along a path - this layout only
#' works well for trees where each node has maximum one parent.
#' @param highlightChildLinks boolean Highlight all the links going right from a node or 
#' link.
#' @param doubleclickTogglesChildren boolean Show/hide target nodes and paths to the left
#'  on double-click. Does not hide incoming links of target nodes, yet.
#' @param curvature numeric Curvature parameter for bezier links - between 0 and 1.
#' @param showNodeValues boolean Show values above nodes. Might require and increased node margin.
#' @param scaleNodeBreadthsByString Put nodes at positions relatively to string lengths - 
#' only work well currently with align='none'
#' @param yOrderComparator Order nodes on the y axis by a custom function instead of ascending or 
#' descending depth.
#'
#' @examples
#' \dontrun{
#' # Recreate Bostock Sankey diagram: http://bost.ocks.org/mike/sankey/
#' # Load energy projection data
#' URL <- paste0('https://cdn.rawgit.com/christophergandrud/networkD3/',
#'               'master/JSONdata/energy.json')
#' energy <- jsonlite::fromJSON(URL)
#' 
#' # Plot
#' sankeyNetwork(Links = energy$links, Nodes = energy$nodes, Source = 'source',
#'              Target = 'target', Value = 'value', NodeID = 'name',
#'              units = 'TWh', fontSize = 12, nodeWidth = 30)
#'
#' # Colour links
#' energy$links$energy_type <- sub(' .*', '',
#'                                energy$nodes[energy$links$source + 1, 'name'])
#'
#' sankeyNetwork(Links = energy$links, Nodes = energy$nodes, Source = 'source',
#'              Target = 'target', Value = 'value', NodeID = 'name',
#'              LinkGroup = 'energy_type', NodeGroup = NULL)
#'
#' # labelValue
#' energy$links$value_print <- energy$links$value * 10
#' sankeyNetwork(Links = energy$links, Nodes = energy$nodes, Source = 'source',
#'              Target = 'target', Value = 'value', 
#'              labelValue = "value_print", NodeID = 'name',
#'              units = 'TWh', fontSize = 12, nodeWidth = 30)
#'     
#' # multiple labelValue with custom options        
#' energy$links$log_size_value <- log(energy$links$value)
#' energy$links$label_value_1 <- energy$links$value
#' energy$links$label_value_2 <- sample(c(2, 5, 4), nrow(energy$links), replace = T)
#' sankeyNetwork(Links = energy$links, Nodes = energy$nodes, Source = 'source',
#'               Target = 'target', NodeID = 'name',Value = 'log_size_value', 
#'               labelValue = c("label_value_1", "label_value_2"), 
#'               units = c('TWh', "N"), # custom units
#'               numberFormat = c(",.5g", ",.0r"), # custom format
#'               fontSize = 12, nodeWidth = 30)
#'              
#' }
#' @source
#' D3.js was created by Michael Bostock. See \url{http://d3js.org/} and, more
#' specifically for Sankey diagrams \url{http://bost.ocks.org/mike/sankey/}.
#'
#' @seealso \code{\link{JS}}
#'
#' @export
sankeyNetwork <- function(Links, Nodes, Source, Target, Value, 
    NodeID, NodeGroup = NodeID, labelValue = Value, LinkGroup = NULL, 
    NodePosX = NULL, NodeValue = NULL,
    NodeColor = NULL, NodeFontColor = NULL, NodeFontSize = NULL,
    units = "", colourScale = JS("d3.scaleOrdinal().range(d3.schemeCategory20)"), 
    fontSize = 7,  fontFamily = NULL, fontColor = NULL,
    nodeWidth = 15, nodePadding = 10, nodeStrokeWidth = 1, nodeCornerRadius = 0,
    margin = NULL, title = NULL,
    numberFormat = ",.5g", orderByPath = FALSE, highlightChildLinks  = FALSE,
    doubleclickTogglesChildren = FALSE, xAxisDomain = NULL,
    dragX = FALSE, dragY = FALSE,
    height = NULL, width = NULL, iterations = 32, zoom = FALSE, align = "justify",
    showNodeValues = TRUE, linkType = "bezier", curvature = .5,  linkColor = "#A0A0A0",
    nodeLabelMargin = 2, linkOpacity = .5, linkOpacityHover = 1,
    linkGradient = FALSE, nodeShadow = FALSE, 
    scaleNodeBreadthsByString = FALSE, xScalingFactor = 1,
    yOrderComparator = NULL) 
{
 
   # Check if data is zero indexed
    check_zero(Links[, Source], Links[, Target])
    
    # Hack for UI consistency. Think of improving.
    colourScale <- as.character(colourScale)
    
    # If tbl_df convert to plain data.frame
    Links <- tbl_df_strip(Links)
    Nodes <- tbl_df_strip(Nodes)
    
    # Subset data frames for network graph
    if (!is.data.frame(Links)) {
        stop("Links must be a data frame class object.")
    }
    if (!is.data.frame(Nodes)) {
        stop("Nodes must be a data frame class object.")
    }
    # if Source or Target are missing assume Source is the first
    # column Target is the second column
    if (missing(Source)) 
        Source = 1
    if (missing(Target)) 
        Target = 2
    
    LinksDF <- data.frame(source=Links[, Source], target = Links[, Target])
    
    if (missing(Value)) {
        LinksDF$value = 1
    } else {
        LinksDF$value <- Links[, Value]
    }
    
    if(length(labelValue) == 1 && !missing(Value) && labelValue == Value){
      LinksDF$labelValue <- Links[, labelValue]
      labelValue <- "labelValue"
    } else {
      LinksDF <- cbind.data.frame(LinksDF, Links[, labelValue, drop = FALSE])
    }
    
    # if NodeID is missing assume NodeID is the first column
    if (missing(NodeID)) 
        NodeID = 1
    NodesDF <- data.frame(name=Nodes[, NodeID], stringsAsFactors = FALSE)
    
    # add node group if specified
    if (is.character(NodeGroup)) {
        NodesDF$group <- Nodes[, NodeGroup]
    }

    if (is.character(NodePosX)) {
        NodesDF$posX <- Nodes[, NodePosX]
    }

    if (is.character(NodeValue)) {
        NodesDF$value <- Nodes[, NodeValue]
        NodesDF$labelValue <- NodesDF$value
        labelValue_nodes <- "labelValue"
    } else {
      NodesDF$`_tmp_gr` <- 1:nrow(NodesDF)-1
      for(v in labelValue){
        value_node_source <- aggregate(LinksDF[[v]], by= list(LinksDF$source), "sum")
        colnames(value_node_source) <- c("group", "source")
        value_node_target <- aggregate(LinksDF[[v]], by= list(LinksDF$target), "sum")
        colnames(value_node_target) <- c("group", "target")
        value_node <- merge(value_node_source, value_node_target, by = "group", all = T)
        value_node$value <- pmax(value_node$source, value_node$target,  na.rm = TRUE)
        
        value_node_merge <- value_node[, c("group", "value")]
        colnames(value_node_merge) <- c("_tmp_gr", v)
        
        NodesDF <- merge(NodesDF, value_node_merge, all.x = TRUE, sort = FALSE)
      }
  
      NodesDF <- NodesDF[order(NodesDF$`_tmp_gr`), ]
      NodesDF$`_tmp_gr` <- NULL
      labelValue_nodes <- labelValue
    }
    
    if (is.character(NodeColor)) {
        NodesDF$color = Nodes[, NodeColor]
    }
    
    if (is.character(NodeFontSize)) {
        NodesDF$fontSize = Nodes[, NodeFontSize]
    }
    
    if (is.character(NodeFontColor)) {
        NodesDF$fontColor = Nodes[, NodeFontColor]
    }
    
    if (is.character(LinkGroup)) {
        LinksDF$group <- Links[, LinkGroup]
    }

    if(length(labelValue) != length(units)){
      units <- rep(units, length = length(labelValue))
    }
    
    if(length(labelValue) != length(numberFormat)){
      numberFormat <- rep(numberFormat, length = length(labelValue))
    }
    
    margin <- margin_handler(margin)
    
    if(length(labelValue_nodes) == 1) labelValue_nodes <- list(labelValue_nodes)
    if(length(labelValue) == 1) labelValue <- list(labelValue)
    if(length(units) == 1) units <- list(units)
    if(length(numberFormat) == 1) numberFormat <- list(numberFormat)

    # create options
    options = list(NodeID = NodeID, NodeGroup = NodeGroup, LinkGroup = LinkGroup, 
        colourScale = colourScale, fontSize = fontSize, fontFamily = fontFamily, fontColor = fontColor,
        nodeWidth = nodeWidth, nodePadding = nodePadding, nodeStrokeWidth = nodeStrokeWidth,
        nodeCornerRadius = nodeCornerRadius, dragX = dragX, dragY = dragY,
        numberFormat = numberFormat, orderByPath = orderByPath,
        units = units, margin = margin, iterations = iterations, 
        zoom = zoom, linkType = linkType, curvature = curvature,
        highlightChildLinks = highlightChildLinks, doubleclickTogglesChildren = doubleclickTogglesChildren,
        showNodeValues = showNodeValues, align = align, xAxisDomain = xAxisDomain,
        title = title, nodeLabelMargin = nodeLabelMargin, 
        linkColor = linkColor, linkOpacity = linkOpacity, linkOpacityHover = linkOpacityHover, 
        linkGradient = linkGradient, nodeShadow = nodeShadow,
        scaleNodeBreadthsByString = scaleNodeBreadthsByString, xScalingFactor = xScalingFactor,
        yOrderComparator = yOrderComparator, labelValue_nodes = labelValue_nodes, 
        labelValue_links = labelValue)
    
    # create widget
    htmlwidgets::createWidget(name = "sankeyNetwork", x = list(links = LinksDF, 
        nodes = NodesDF, options = options), width = width, height = height, 
        sizingPolicy = htmlwidgets::sizingPolicy(padding = 10, browser.fill = TRUE), 
        dependencies = list(d3r::d3_dep_v4(), sankey_dep()),
        package = "sankeyD3")
}

#' @keywords internal
sankey_dep <- function() {
  htmltools::htmlDependency(
    name = "sankey",
    version = "0.1",
    src = c(
      file = system.file("htmlwidgets/lib/d3-sankey/src", package="sankeyD3")
    ),
    script = "sankey.js"#,
    #stylesheet = "d2b_custom.css"
  )
}

#' @rdname sankeyD3-shiny
#' @export
sankeyNetworkOutput <- function(outputId, width = "100%", height = "500px") {
    htmlwidgets::shinyWidgetOutput(outputId, "sankeyNetwork", width, height, 
        package = "sankeyD3")
}

#' @rdname sankeyD3-shiny
#' @export
renderSankeyNetwork <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) 
        {
            expr <- substitute(expr)
        }  # force quoted
  htmlwidgets::shinyRenderWidget(expr, sankeyNetworkOutput, env, quoted = TRUE)
}
