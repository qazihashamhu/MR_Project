function helperPlotAveragedMetrics(benchmarkObjs, runCount, metricName)
%helperPlotAveragedMetrics plot the averaged metric value across all benchmark
% objects in a boxchart

% Copyright 2021 The MathWorks Inc. 

    numObjs = length(benchmarkObjs);
    numPlanners = numel(benchmarkObjs{1}.PlannerOutput);
    sumMetricVal = zeros(numPlanners, runCount);
    %Finding the sum of all metric value across all the plannerBenchmark objects 
    for i=1:numObjs
        pbo = benchmarkObjs{i};
        [~, metricTables] = pbo.metric();

        metricVal = metricTables.(metricName){:,:};
        metricVal(isnan(metricVal)) = 0;
        sumMetricVal = sumMetricVal + metricVal;
    end
    %The average metric value for each run across numObjs is calculated
    meanMetricVal = sumMetricVal./numObjs;
    helperDisplayMetric(pbo, metricName, meanMetricVal);
    title(metricName);
end

function helperDisplayMetric(obj, metricName, metricVal)
    if strcmp(metricName,'isPathValid')
        metricVal = mean(metricVal,2)*100;
        bar(metricVal);
    else
        if(size(metricVal,2) == 1)
            metricVal = [metricVal,metricVal];
        end
   
        %metric contains each planner as a row and number of runs as column
        boxchart(metricVal');
    end
    labels = fieldnames(obj.PlannerOutput);
    set(gca,'xticklabel', labels, "XTickLabelRotation", 0, ...
        'TickLabelInterpreter','none');

    xlabel('Planner');
    ylabel(metricName,'Interpreter','none');
 
end