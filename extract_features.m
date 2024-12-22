function features = extract_features(filepaths)
    features = [];
    
    for f = 1:numel(filepaths)
        if mod(f, 200) == 0
            fprintf('%d/%d (%.2f%%)\n', f, numel(filepaths), 100 * f / numel(filepaths));
        end
        
        % Load and convert image to double
        im = im2double(imread(filepaths{f}));
        
        % Convert to YCbCr and extract luminance channel
        img_ycbcr = rgb2ycbcr(im);
        lum = img_ycbcr(:, :, 1);
        
        % Feature 1: Luminance moments (mean, variance, skewness)
        luminance_moments = [squeeze(mean(lum, [1, 2]))', squeeze(var(lum, 0, [1, 2]))', squeeze(skewness(lum, 0, [1, 2]))'];
        
        % Feature 2: Contrast (max - min intensity)
        contrast = squeeze(max(lum(:)) - min(lum(:)));
        
        % Feature 3: Min-max bins from histogram (10 bins)
        counts = histcounts(lum, 10);
        minmax_bins = squeeze([counts(1), counts(end)]);
        
        % Combine all features
        extracted_features = [luminance_moments, contrast, minmax_bins];
        
        % Append features
        features = [features; extracted_features];
    end
end
