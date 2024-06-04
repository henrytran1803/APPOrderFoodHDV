
# API DOCUMENT
## Base URL: http://localhost:port/
| Mã Trạng Thái | Trạng Thái          | Mô Tả                                                               |
|---------------|---------------------|---------------------------------------------------------------------|
| 200           | OK                  | Mọi thứ hoạt động như dự kiến.                                      |
| 400           | Bad Request         | Yêu cầu không chấp nhận, thường do thiếu một tham số bắt buộc.       |
| 401           | Unauthorized        | Không có API key hợp lệ được cung cấp.                              |
| 402           | Request Failed      | Các tham số hợp lệ nhưng yêu cầu thất bại.                           |
| 403           | Forbidden           | API key không có quyền thực hiện yêu cầu.                            |
| 404           | Not Found           | Tài nguyên được yêu cầu không tồn tại.                               |
| 409           | Conflict            | Yêu cầu xung đột với yêu cầu khác (có thể do sử dụng cùng một khóa idempotent). |
| 429           | Too Many Requests   | Quá nhiều yêu cầu đến API quá nhanh. Chúng tôi khuyến nghị giãn cách mũi nhọn của yêu cầu của bạn. |
| 500, 502, 503, 504 | Server Errors | Có điều gì đó sai sót ở phía Stripe. (Những điều này hiếm khi xảy ra.) |
---
# API USER-SERVICE
## Đăng nhập
### /api/login/singin [post] 
**request method: [POST]**
**Request**
~~~ json
{
"email":"email@gmail.com",
"password":"password@aA"
}
~~~

**Response**

~~~ json
{
"status": ,
"message" ,
"data":
}
~~~
{
    "username": "huydien",
    "email": "dienchau45@gmail.com",
    "password": "dienchau45",
    "phone": "0123456789",
    "address": "Binh Dinh"
}
## Đăng ký
### /api/login/signup 
**request method: [POST]**
**Request**
~~~ json
{
    "username": "username",
    "email": "emai@gmail.com",
    "password": "Pass@word",
    "phone": "+84 blabla",
    "address": "address"
}
~~~

**Response**

~~~ json
{
"status": ,
"message" ,
"data":
}
~~~
---
# API PRODUCT-SERVICE
## CATEGORY
**Base:** /api/categories
- **Lấy danh sách danh mục**
    **request method:** [GET]
    **Request:** /api/categories
    ~~~json
    {}
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Lấy danh mục theo id**
    **request method:** [GET]
    **Request:** /api/categories/{id}
    ~~~json
    {}
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Thêm danh mục**
    **request method:** [POST]
    **Request:** /api/categories
    ~~~json
    {}
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Sửa danh mục theo id**
    **request method:** [PUT]
    **Request:** /api/categories/{id}
    ~~~json
    {}
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Xoá danh mục theo id**
    **request method:** [DELETE]
    **Request:** /api/categories/{id}
    ~~~json
    {}
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
## PRODUCT
**Base:** /api/products
- **Lấy danh sách danh sản phẩm**
    **request method:** [GET]
    **Request:** /api/products
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Lấy ra sản phẩm theo id**
    **request method:** [GET]
    **Request:** /api/products/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Thêm sản phẩm**
    **request method:** [POST]
    **Request:** /api/products
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Sửa sản phẩm theo id**
    **request method:** [PUT]
    **Request:** /api/products/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Xoá sản phẩm theo id**
    **request method:** [DELETE]
    **Request:** /api/products/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
---
# API PAYMENT-SERVICE
**Base:** /api/payments/
- **Lấy tất cả các thanh toán**
    **request method:** [GET]
    **Request:** /api/payments
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Thêm thanh toán mới**
    **request method:** [POST]
    **Request:** /api/payments
    ~~~json
    {
        
    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Sửa thanh toán theo id**
    **request method:** [PUT]
    **Request:** /api/payments/{id}
    ~~~json
    {
        
    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Xoá thanh toán theo id**
    **request method:** [DELETE]
    **Request:** /api/payments/{id}
    ~~~json
    {
        
    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
## Thanh toán với VNPAY
- **Thêm thanh toán với VNPAY**
    **Base:** /api/payments/vnpay/create
    **request method:** [POST]
    **Request:** /api/payments/{id}
    ~~~json
    {
        
    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Call back VNPAY**
    **Base:** /api/payments/vnpay/callback
    **request method:** [POST]
    **Request:** /api/payments/{id}
    ~~~json
    {
        
    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~

---
# API ORDER-SERVICE
## CART
**Base:** /api/carts
- **Lấy hết tất cả các giỏ hàng**
    **Base:** /api/carts
    **request method:** [GET]
    **Request:**
    ~~~json
    {
        
    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Lấy giỏ hàng theo id**
    **request method:** [GET]
    **Request:** /api/carts/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Thêm giỏ hàng mới**
    **request method:** [POST]
    **Request:** /api/carts
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Sửa giỏ hàng theo id**
    **request method:** [PUT]
    **Request:** /api/carts/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Xoá giỏ hàng theo id**
    **request method:** [DELETE]
    **Request:** /api/carts/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
## ORDER
**Base:** /api/orders
- **Lấy hết tất cả các đơn hàng**
    **Base:** /api/orders
    **request method:** [GET]
    **Request:**
    ~~~json
    {
        
    }
    ~~~
- **Lấy đơn hàng theo id**
    **request method:** [GET]
    **Request:** /api/orders/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Thêm đơn hàng mới**
    **request method:** [POST]
    **Request:** /api/orders
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Sửa đơn hàng theo id**
   **request method:** [PUT]
    **Request:** /api/orders/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
- **Xoá đơn hàng theo id**
    **request method:** [DELETE]
    **Request:** /api/orders/{id}
    ~~~json
    {

    }
    ~~~
    **Response:** 
    ~~~json
    {

    }
    ~~~
---
# API NOFICATION-SERVICE
## EMAIL
**Base:** /api/email
- **Gửi email đơn**

- **Gửi email với đơn**

- **Gửi email**

## NOFICATION
**Base:** /api/nofications
- **Lấy hết tất cả thông báo**
- **Lấythông báo theo id**
- **Thêm thông báo mới**
- **Xoá thông báo theo id**
## PAYMENT
**Base:** /api/payments
