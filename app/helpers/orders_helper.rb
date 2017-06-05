module OrdersHelper
 def render_order_paid_state(order)
   if order.is_paid?
     "已付款"
   else
     "未付款"
   end
 end

  # 訂單狀態
  def render_order_status(order)
    case order.aasm_state
    when 'order_placed'
      t('已下单，请付款以确认订单')
    when 'paid'
      t('订单付款成功，准备出货')
    when 'shipping'
      t('订单出货中')
    when 'shipped'
      t('商品已送达')
    when 'order_cancelled'
      t('订单已取消')
    when 'good_returned'
      t('订单已退货')
    end
  end
end
