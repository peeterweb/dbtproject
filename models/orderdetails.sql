select
o.order_id,
o.product_id,
o.unit_price,
o.quantity,
p.product_name,
p.supplier_id,
p.category_id, 
o.unit_price * o.quantity total,
(p.unit_price * o.quantity) - total discount
from {{source('sources','order_details')}} o
left join
{{source('sources','products')}} p on (o.product_id = p.product_id)