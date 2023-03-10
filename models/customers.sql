-- Usar CTE
-- descobrir campos duplicados
with markup as (
    select *, 
    first_value(customer_id)
    over(partition by company_name, contact_name -- possíveis campos duplicados
    order by company_name
    rows between unbounded preceding and unbounded following) as result
    from {{source('sources','customers')}}     -- Template Jinja
), removed as (         -- remover duplicados
    select distinct result from markup
), final as (           -- criando tabela final com todos os dados sem duplicação
    select * from {{source('sources','customers')}} where customer_id in (select result from removed)
)
select * from final