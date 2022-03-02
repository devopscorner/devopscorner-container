SELECT total_time, min_time, max_time, mean_time, calls, query
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 100;