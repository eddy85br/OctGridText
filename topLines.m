function bests = topLines(pop, fitvals)
	bests = pop(fitvals == min(fitvals),:);

