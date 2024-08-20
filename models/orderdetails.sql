select 
od.order_id,
od.product_id,
pr.product_name,
od.unit_price,
od.quantity,
pr.supplier_id,
pr.category_id,
od.unit_price * od.quantity as total,
pr.unit_price - od.quantity - total as discount
from {{source('sources','order_details')}} od
left join {{source('sources','products')}} pr
    on od.product_id = pr.product_id