with prod as (
select
    ct.category_name, 
    sp.company_name suppliers, 
    pd.product_name, 
    pd.unit_price, 
    pd.product_id
    from {{source('sources', 'products')}} pd
    left join {{source('sources', 'suppliers')}} sp on pd.supplier_id = sp.supplier_id
    left join {{source('sources', 'categories')}} ct on pd.category_id = ct.category_id
), odetail as (
    select pd.*, od.order_id, od.quantity, od.discount
    from {{ref('orderdetails')}} od
    left join prod pd on od.product_id = pd.product_id
), ordrs as (
    select
    os.order_date, 
    os.order_id, 
    cs.company_name customer,
    em.name employee, 
    em.age, 
    em.length_of_service
    from {{source('sources', 'orders')}} os
    left join {{ref('customers')}} cs on os.customer_id = cs.customer_id
    left join {{ref('employees')}} em on os.employee_id = em.employee_id
    left join {{source('sources', 'shippers')}} sh on os.ship_via = sh.shipper_id
), final as (
    select 
    od.*, 
    os.order_date, 
    os.customer, 
    os.employee, 
    os.age, 
    os.length_of_service
    from odetail od
    inner join ordrs os on od.order_id = os.order_id
)
select * from final