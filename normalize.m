function normed = normalize(data)

  baseline = mean(data(1:500));
  normed = (data - baseline) / (max(data) - baseline);
end

