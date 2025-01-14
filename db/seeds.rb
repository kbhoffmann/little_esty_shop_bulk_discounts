
#merchant 1 Items and Discounts
merchant1 = Merchant.create!(name: 'Cat Stuff')
discount1 = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchant1.id)
discount2 = Discount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: merchant1.id)
discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 20, merchant_id: merchant1.id)
item1 = Item.create!(name: "Whisker Lickers", description: "Cat Treats", unit_price: 7, status: 1, merchant_id: merchant1.id)
item2 = Item.create!(name: "Glitter Ball", description: "Cat Toy", unit_price: 2, status: 1, merchant_id: merchant1.id)
item3 = Item.create!(name: "Tidy Cat Litter", description: "Cat Litter", unit_price: 10, status: 1, merchant_id: merchant1.id)
#merchant 2 Items and Discounts
merchant2 = Merchant.create!(name: 'Dog Stuff')
discount4 = Discount.create!(percentage_discount: 10, quantity_threshold: 5, merchant_id: merchant2.id)
discount5 = Discount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchant2.id)
discount6 = Discount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: merchant2.id)
item4 = Item.create!(name: "Beggin Strips", description: "Dog Treats", unit_price: 6, status: 1, merchant_id: merchant2.id)
item5 = Item.create!(name: "Rope Pull", description: "Dog Toy", unit_price: 9, status: 1, merchant_id: merchant2.id)
item6 = Item.create!(name: "Plaid leash", description: "Leash", unit_price: 12, status: 1, merchant_id: merchant2.id)
#merchant3 Items and Discounts
merchant3 = Merchant.create!(name: 'Bird Stuff')
discount7 = Discount.create!(percentage_discount: 30, quantity_threshold: 7, merchant_id: merchant3.id)
discount8 = Discount.create!(percentage_discount: 40, quantity_threshold: 17, merchant_id: merchant3.id)
discount9 = Discount.create!(percentage_discount: 50, quantity_threshold: 27, merchant_id: merchant3.id)
item7 = Item.create!(name: "Birdie Chow", description: "Bird Seed", unit_price: 11, status: 1, merchant_id: merchant3.id)
item8 = Item.create!(name: "Rollie Penguin", description: "Bird Toy", unit_price: 8, status: 1, merchant_id: merchant3.id)
item9 = Item.create!(name: "Cuddle Bone", description: "Bird Treat", unit_price: 4, status: 1, merchant_id: merchant3.id)

#customers and invoices
kerri     = Customer.create!(first_name: 'Kerri', last_name: 'Wollner')
invoice1  = Invoice.create!(customer_id: kerri.id, status: 2)
invoice2  = Invoice.create!(customer_id: kerri.id, status: 1)
invoice3  = Invoice.create!(customer_id: kerri.id, status: 2)

rob       = Customer.create!(first_name: 'Rob', last_name: 'Kitsch')
invoice4  = Invoice.create!(customer_id: rob.id, status: 2)
invoice5  = Invoice.create!(customer_id: rob.id, status: 1)
invoice6  = Invoice.create!(customer_id: rob.id, status: 2)

dana      = Customer.create!(first_name: 'Dana', last_name: 'Bode')
invoice7  = Invoice.create!(customer_id: dana.id, status: 2)
invoice8  = Invoice.create!(customer_id: dana.id, status: 1)
invoice9  = Invoice.create!(customer_id: dana.id, status: 2)

#invoice_items
ii1   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 7, invoice_id: invoice1.id, item_id: item1.id)
ii2   = InvoiceItem.create!(status: 1, quantity: 5, unit_price: 2, invoice_id: invoice1.id, item_id: item2.id)
ii3   = InvoiceItem.create!(status: 2, quantity: 25, unit_price: 10, invoice_id: invoice1.id, item_id: item3.id)

ii4   = InvoiceItem.create!(status: 2, quantity: 5, unit_price: 6, invoice_id: invoice2.id, item_id: item4.id)
ii5   = InvoiceItem.create!(status: 1, quantity: 15, unit_price: 9, invoice_id: invoice2.id, item_id: item5.id)
ii6   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 12, invoice_id: invoice2.id, item_id: item6.id)

ii7   = InvoiceItem.create!(status: 2, quantity: 27, unit_price: 11, invoice_id: invoice3.id, item_id: item7.id)
ii8   = InvoiceItem.create!(status: 1, quantity: 7, unit_price: 8, invoice_id: invoice3.id, item_id: item8.id)
ii9   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 4, invoice_id: invoice3.id, item_id: item9.id)
#---------
ii10   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 7, invoice_id: invoice4.id, item_id: item1.id)
ii11   = InvoiceItem.create!(status: 1, quantity: 5, unit_price: 2, invoice_id: invoice4.id, item_id: item2.id)
ii12   = InvoiceItem.create!(status: 2, quantity: 25, unit_price: 10, invoice_id: invoice4.id, item_id: item3.id)

ii13   = InvoiceItem.create!(status: 2, quantity: 5, unit_price: 6, invoice_id: invoice5.id, item_id: item4.id)
ii14   = InvoiceItem.create!(status: 1, quantity: 15, unit_price: 9, invoice_id: invoice5.id, item_id: item5.id)
ii15   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 12, invoice_id: invoice5.id, item_id: item6.id)

ii16   = InvoiceItem.create!(status: 2, quantity: 27, unit_price: 11, invoice_id: invoice6.id, item_id: item7.id)
ii17   = InvoiceItem.create!(status: 1, quantity: 7, unit_price: 8, invoice_id: invoice6.id, item_id: item8.id)
ii18   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 4, invoice_id: invoice6.id, item_id: item9.id)
#---------
ii19   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 7, invoice_id: invoice7.id, item_id: item1.id)
ii20   = InvoiceItem.create!(status: 1, quantity: 5, unit_price: 2, invoice_id: invoice7.id, item_id: item2.id)
ii21   = InvoiceItem.create!(status: 2, quantity: 25, unit_price: 10, invoice_id: invoice7.id, item_id: item3.id)

ii22   = InvoiceItem.create!(status: 2, quantity: 5, unit_price: 6, invoice_id: invoice8.id, item_id: item4.id)
ii23   = InvoiceItem.create!(status: 2, quantity: 15, unit_price: 9, invoice_id: invoice8.id, item_id: item5.id)
ii24   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 12, invoice_id: invoice8.id, item_id: item6.id)

ii25   = InvoiceItem.create!(status: 2, quantity: 27, unit_price: 11, invoice_id: invoice9.id, item_id: item7.id)
ii26   = InvoiceItem.create!(status: 2, quantity: 7, unit_price: 8, invoice_id: invoice9.id, item_id: item8.id)
ii27   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 4, invoice_id: invoice9.id, item_id: item9.id)

#transactions
trans1       = Transaction.create!(result: 1, credit_card_number: 010001001022, credit_card_expiration_date: 20220101, invoice_id: invoice1.id,)
trans2       = Transaction.create!(result: 1, credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: invoice2.id,)
trans3       = Transaction.create!(result: 1, credit_card_number: 010001005551, credit_card_expiration_date: 20220101, invoice_id: invoice3.id,)
trans3       = Transaction.create!(result: 1, credit_card_number: 010001005552, credit_card_expiration_date: 20220101, invoice_id: invoice4.id,)
trans4       = Transaction.create!(result: 1, credit_card_number: 010001005553, credit_card_expiration_date: 20220101, invoice_id: invoice5.id,)
trans4       = Transaction.create!(result: 1, credit_card_number: 010001005554, credit_card_expiration_date: 20220101, invoice_id: invoice6.id,)
trans4       = Transaction.create!(result: 1, credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: invoice7.id,)
trans4       = Transaction.create!(result: 1, credit_card_number: 010001005556, credit_card_expiration_date: 20220101, invoice_id: invoice8.id,)
trans4       = Transaction.create!(result: 1, credit_card_number: 010001005557, credit_card_expiration_date: 20220101, invoice_id: invoice9.id,)
