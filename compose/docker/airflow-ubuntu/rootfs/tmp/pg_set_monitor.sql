create user datadog with password '';

grant pg_monitor to datadog;
grant SELECT ON pg_stat_database to datadog;

grant pg_monitor to postgres;
grant SELECT ON pg_stat_database to postgres;
