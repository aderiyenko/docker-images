createdb postgis_template -E UTF8
psql -d postgis_template -c "create extension if not exists postgis;"
