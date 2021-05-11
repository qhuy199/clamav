#### clamav & REST API
Basic concept:
Docker Swarm chạy 2 docker services: "clamav" và "rest api".

**"clamav"**
- Mở port tcp 3310 cho dịch vụ clamd xử lý các yêu cầu scan virus gửi đến.
- Signatures: Clamav & SecuriteInfo
- Daemon freshclam tự động update signature: Kiểm tra update mỗi 2 tiếng. `Note: ` SecuriteInfo chỉ chấp nhận tối đa 24 lần download / ngày

**"rest api"**
- Mở port 8080 nhận request từ Client rồi đẩy sang "clamav" xử lý

Chấp nhận tối đa:
- 4 Files / request
- 25 MB / File

#### Chạy "clamav" và "rest api" trên Docker Swarm:
`Note:` File cấu hình freshclam.conf trên git chưa bao gồm cài đặt cho SecuriteInfo. Sẽ được thêm vào sau khi đã đưa lên product.
```bash
gh repo clone qhuy199/clamav
cd clamav
docker stack deploy --compose-file docker-compose.yml clamav
```
#### API endpoints

There are only two API endpoints:

`POST /api/v1/scan` - to scan files

`GET /api/v1/version` - to get ClamAV version


#### Test thử REST API
```bash
curl -s -XPOST http://localhost:8080/api/v1/scan -F FILES=@src/tests/1Mfile01.rnd -F FILES=@src/tests/eicar_com.zip | jq
{
  "success": true,
  "data": {
    "result": [
      {
        "name": "1Mfile01.rnd",
        "is_infected": false,
        "viruses": []
      },
      {
        "name": "eicar_com.zip",
        "is_infected": true,
        "viruses": [
          "Win.Test.EICAR_HDB-1"
        ]
      }
    ]
  }
}
```
