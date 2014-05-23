% Do configuration (works only in MatLab) ...
% gaOptions = gaOptionsimset;

% ... or set these parameters:
gaOptions.InitialPopulation = [];
gaOptions.EliteCount        = 5;
gaOptions.MutationRate      = [];
gaOptions.PopulationSize    = 100;
gaOptions.Generations       = 30;
% Run GA for GnuOctave
x = gaGnuOct(@fitnessFunct, 32, gaOptions);
