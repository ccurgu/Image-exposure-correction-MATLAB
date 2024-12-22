function best_gamma = compute_gamma(y_channel, target_mean, target_var)
   % optimal values
   optimal_mean = target_mean;
   optimal_var = target_var;
  
   % objective function
   objective_function = @(gamma) ...
       0.5 * (mean(y_channel .^ gamma, 'all') - optimal_mean)^2 + ...
       0.5 * (var(y_channel .^ gamma, 0, 'all') - optimal_var)^2;
   % optimization options
   options = optimset('Display', 'off', 'Algorithm', 'sqp');
  
   % optimize gamma within bounds
   best_gamma = fmincon(objective_function, 1, [], [], [], [], 0.2, 3, [], options);
end