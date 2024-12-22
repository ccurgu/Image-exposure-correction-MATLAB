function [img_corrected, y_corrected, img_features] = correct_gamma(img, output_folder, filename, dynamic_target_mean, dynamic_target_var)
   % Convert image to YCbCr
   img_ycbcr = rgb2ycbcr(img);
   lum = img_ycbcr(:,:,1);  % Extract luminance (Y) channel
   Cb = img_ycbcr(:,:,2);
   Cr = img_ycbcr(:,:,3);
  
   % Compute the best gamma using dynamic target mean and variance
   best_gamma = compute_gamma(lum, dynamic_target_mean, dynamic_target_var);
  
   % Apply gamma correction
   y_corrected = lum .^ best_gamma;
  
   % Ensure y_corrected values are within valid range [0, 1]
   y_corrected = max(0, min(1, y_corrected));
  
   % Recombine Y, Cb, and Cr channels and convert back to RGB
   img_recombined = cat(3, y_corrected, Cb, Cr);
   img_corrected = ycbcr2rgb(img_recombined);
  
   % Save corrected image
   imwrite(img_corrected, fullfile(output_folder, filename));
   disp(['Gamma for ', filename, ': ', num2str(best_gamma)]);
  
   % --- Feature Extraction ---
  
   % Feature 1: Luminance moments (mean, variance, skewness)
   luminance_moments = [squeeze(mean(y_corrected, [1, 2]))', squeeze(var(y_corrected, 0, [1, 2]))', squeeze(skewness(y_corrected, 0, [1, 2]))'];
  
   % Feature 2: Contrast (max - min intensity)
   contrast = squeeze(max(y_corrected(:)) - min(y_corrected(:)));
  
   % Feature 3: Min-max bins from histogram (10 bins)
   counts = histcounts(y_corrected, 10);
   minmax_bins = squeeze([counts(1), counts(end)]);
  
   % Combine all features into a single feature vector
   img_features = [luminance_moments, contrast, minmax_bins];
end

