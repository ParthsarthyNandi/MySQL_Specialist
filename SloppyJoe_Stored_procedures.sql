use sloppyjoes;

delimiter //

create procedure sp_stafff()
begin
	select 
		staff_id,
        count(order_id) as order_recvd
	from customer_orders
	group by staff_id;
end //

delimiter ;

create procedure sp_staffg()
begin
    select 
        staff_id,
        count(order_id) as order_recvd
    from customer_orders
    group by staff_id;
end //

delimiter ;
