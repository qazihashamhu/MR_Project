function metricTable = helperCalculateAverageMetricTable(benchmarkList, metricName)
%helperCalculateAverageMetricTable return statistics summary of the metric
% in a table 

% Copyright 2021 The MathWorks Inc. 

    numBenchmarks = size(benchmarkList,2);
    plannerNames = fieldnames(benchmarkList{1}.PlannerOutput);
    numPlanners = length(plannerNames);
    metricVal = zeros(numPlanners, numBenchmarks);
    metricSummaryName = strcat(metricName,"Summary");
    for i=1:numBenchmarks
        benchmark = benchmarkList{i};
        metricTables = benchmark.metric();
        if strcmp((metricSummaryName),"isPathValidSummary")
            metricVal(:,i) = metricTables.(metricSummaryName).SuccessRate;       
        else
            metricVal(:,i) = metricTables.(metricSummaryName).Mean;        
        end
    end
    
    Mean = mean(metricVal,2);
    Median = median(metricVal,2);
    stdDev = std(metricVal,1,2);
    metricTable = table(Mean, Median, stdDev);
    metricTable.Properties.RowNames = plannerNames;
end