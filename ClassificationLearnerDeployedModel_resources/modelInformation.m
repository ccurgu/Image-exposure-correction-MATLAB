function modelInfoJSON = modelInformation()
modelInfoStruct = struct();
modelInfoStruct.About = 'Predict on new data using a trained model exported from Classification Learner R2024a.';
modelInfoStruct.Version = '1.0';
modelInfoStruct.InputFormat = 'matrix';
modelInfoStruct.InputColumnOrder = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6'};
modelInfoStruct.InputColumnFormat = {'double', 'double', 'double', 'double', 'double', 'double'};
modelInfoStruct.OutputFormat = 'double';
modelInfoJSON = jsonencode(modelInfoStruct);
end