with product_sales as (
	select
		r.region_name,
		p.product_name,
		sum(f.revenue) as total_revenue,
		dense_rank() over (partition by r.region_name order by sum(f.revenue) desc) as regional_rank
		from fact_sales f
		join dim_regions r
			on f.region_id = r.region_id
		join dim_products p
			on f.product_id = p.product_id
		group by 
			r.region_name,
			p.product_name
)
select 
	region_name,
	regional_rank,
	product_name,
	total_revenue
from product_sales
where regional_rank <= 3
order by region_name, regional_rank;

with MonthlySales as(
	select
		to_char(order_date, 'YYYY-MM') as sales_month,
		cast(sum(revenue) as numeric) as total_revenue
	from fact_sales
	where order_date is not null
	group by to_char(order_date, 'YYYY-MM')
)
select
	sales_month,
	total_revenue,
	LAG(total_revenue) over (order by sales_month) as prev_month_revenue,
	round ((total_revenue - LAG(total_revenue) over (order by sales_month)) / nullif(lag(total_revenue) over (order by sales_month),0)*100,2) as mom_growth_percentage
from MonthlySales;

select
	sales_channel,
	sum(revenue) as total_revenue,
	sum(profit) as total_profit,
	round(cast((sum(profit)/nullif(sum(revenue), 0)) * 100 as numeric) , 2) as profit_margin_pct
	from fact_sales
	group by sales_channel 
	order by profit_margin_pct desc;

select 
	f.sales_channel,
	sum(case when p.gender_category = 'Men' then f.revenue else 0 end) as mens_revenue,
	sum(case when p.gender_category = 'Women' then f.revenue else 0 end) as womens_revenue,
	sum(case when p.gender_category = 'Kids' then f.revenue else 0 end) as kids_revenue
from fact_sales f
join dim_products p
	on f.product_id = p.product_id
group by f.sales_channel;

select 
	p.product_name,
	max(f.mrp) as retail_price,
	sum(f.units_sold) as total_units_sold,
	sum(f.revenue) as total_revenue
from fact_sales f
join dim_products p
	on f.product_id = p.product_id
group by p.product_name
having max(f.mrp) > 2500
	and sum(f.units_sold) < 500
order by total_units_sold;
