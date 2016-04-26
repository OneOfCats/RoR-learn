class CombineItemsInCart < ActiveRecord::Migration
  def up #Применить миграцию
  	Cart.all.each do |cart| #берем каждую корзину
  		sums = cart.line_items.group(:product_id).sum(:quantity) #группируем все line_item по product_id, суммируя их quantity. Получаем как бы таблицу product_id к общему кол-ву элементов с таким id

  		sums.each do |product_id, quantity| #проходим по каждому product_id в получившемся сгруппированном массиве
  			if quantity > 1 #если кол-во в корзине у определенного product_id больше единицы, тогда
  				cart.line_items.where(product_id: product_id).delete_all #удаляем все line_items с таким product_id

  				item = cart.line_items.build(product_id: product_id) #создаём новый line_item и даём ему этот product_id
  				item.quantity = quantity #и даём ему суммарное кол-во, которое получили ещё до этого цикла. Т.е., удаляем все единичные вхождения и заменяем их на одиночное вхождение с полем "количество" равным кол-ву единичных вхождений
  				item.save!
  			end
  		end
  	end
  end

  def down #Отменить миграцию
  	LineItem.where("quantity>1").each do |line_item| #Находим все товары в корзине, которых > 1, и заменяем каждый такой товар несколькими товарами с кол-вом 1 (т.е., отменяем эту миграцию)
  		line_item.quantity.times do
  			LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
  		end

  		line_item.destroy
  	end
  end
end
