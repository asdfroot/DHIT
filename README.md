# Yii2 Application with Docker

## 🛠️ Prasyarat
* Docker version 28.2.2
* Docker Compose version 2.37
* Ubuntu 24.04.3 LTS

## Cara Instalasi
-   Clone repositori ini
-   Docker Compose
    ```sh
    docker compose up -d --build
    ```
-   Jalankan perintah **docker ps** pastikan semuanya berjalan
-   Pada browser buka **http://IP** aplikasi yii, **http://IP:9090** prometheus dan **http://IP:3001** grafana

## Setup Monitoring
-   Buka **http://IP:9090** > **Status** > **Target Health** pastikan statusnya up (Hijau)
-   Buka Grafana **http://IP:3001** (default: user **admin** / pass **admin**)
-   Menu Grafana > **Connections** > **Data Sources**
-   Klik **Add Data Source** dan pilih **Prometheus**
-   Prometheus server URL:
    
    ```sh
    http://prometheus:9090
    ```
-   klik **Save & Test** dan pastikan muncul notifikasi hijau
-   Pada pojok kanan atas klik icon **+** > **Import Dashboard**
-   Kolom **Find and Import....**, masukkan ID: **1860** > **Load**
-   Klik **Import**

# Tes volume local agar data tidak hilang ketika container dihapus
-   Buat tabel atau data

    ```sh
    docker exec -it postgres-db psql -U user -d yii2db -c "CREATE TABLE test_data (id serial PRIMARY KEY, name VARCHAR(50));"
    ```

    ```sh
    docker exec -it postgres-db psql -U user -d yii2db -c "INSERT INTO test_data (name) VALUES ('inidata');"
    ```
    
    ```sh
    docker exec -it postgres-db psql -U user -d yii2db -c "SELECT * FROM test_data;"
    ```
-   Mematikan semua container

    ```sh
    docker compose down
    ```
-   Jalankan ulang

    ```sh
    docker compose up -d
    ```

-   Cek data yg sebelumnya sudah dibuat

    ```sh
    docker exec -it postgres-db psql -U user -d yii2db -c "SELECT * FROM test_data;"
    ```


    



