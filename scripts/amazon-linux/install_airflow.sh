#!/usr/bin/env sh

# ================================================================================================
#  INSTALL AIRFLOW (AMAZON LINUX)
# ================================================================================================
AIRFLOW_VERSION="2.2.4"
AIRFLOW_PATH="/home/ec2-user/airflow"
AIRFLOW_DAGS="$AIRFLOW_PATH/dags"

$(mkdir -p $AIRFLOW_DAGS)

airflow_download_dir="$AIRFLOW_PATH"

pip3 download --no-deps "apache-airflow==${AIRFLOW_VERSION}" --dest "${airflow_download_dir}"

curl "https://downloads.apache.org/airflow/${AIRFLOW_VERSION}/apache_airflow-${AIRFLOW_VERSION}-py3-none-any.whl.asc" \
    -L -o "${airflow_download_dir}/apache_airflow-${AIRFLOW_VERSION}-py3-none-any.whl.asc"
curl "https://downloads.apache.org/airflow/${AIRFLOW_VERSION}/apache_airflow-${AIRFLOW_VERSION}-py3-none-any.whl.sha512" \
    -L -o "${airflow_download_dir}/apache_airflow-${AIRFLOW_VERSION}-py3-none-any.whl.sha512"
echo

echo "Please verify files downloaded to ${airflow_download_dir}"
ls -la "${airflow_download_dir}"
echo
