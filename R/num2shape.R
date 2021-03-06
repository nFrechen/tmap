num2shape <- function(x, 
					  n = 5,
					  style = "pretty",
					  breaks = NULL,
					interval.closure="left",
					shapes = NULL,
					legend.labels = NULL,
					shapeNA = NA,
					legend.NA.text = "Missing",
					showNA=NA,
					legend.format=list(scientific=FALSE)) {
	breaks.specified <- !is.null(breaks)
	q <- num2breaks(x=x, n=n, style=style, breaks=breaks, interval.closure=interval.closure)

	breaks <- q$brks
	nbrks <- length(breaks)
	
	if (length(shapes) < (nbrks-1)) {
		warning("Not enough symbol shapes available. Shapes will be re-used.", call.=FALSE)
	}
	shapes <- rep(shapes, length.out=nbrks-1)
	
	int.closure <- attr(q, "intervalClosure")
	
	ids <- findCols(q)
	shps <- shapes[ids]
	anyNA <- any(is.na(shps))
	if (anyNA) {
		if (is.na(showNA)) showNA <- TRUE
		shps[is.na(shps)] <- shapeNA
	} else {
		if (is.na(showNA)) showNA <- FALSE
	}
	
	if (showNA) shapes <- c(shapes, shapeNA)
	
	legend.values <- breaks
	
	# create legend labels for discrete cases
	if (is.null(legend.labels)) {
		legend.labels <- do.call("fancy_breaks", c(list(vec=breaks, intervals=TRUE, interval.closure=int.closure), legend.format)) 
	} else {
		if (length(legend.labels)!=nbrks-1) warning("number of legend labels should be ", nbrks-1, call. = FALSE)
		legend.labels <- rep(legend.labels, length.out=nbrks-1)
	}
	
	if (showNA) legend.labels <- c(legend.labels, legend.NA.text)
	
	list(shps=shps, legend.labels=legend.labels, legend.values=legend.values, shapes=shapes)
}

