user = User.create(first_name: "Paul", last_name: "clegg", email: "paul@paul.com", password_digest: "12345", phone: "773-355-1422")
address1 = Address.create(street: "1462 W Carmen Ave Apt 2", city: "Chicago", state: "IL", zip_code: "60640")
address2 = Address.create(street: "4950 N Marine Dr Apt 103", city: "Chicago", state: "IL", zip_code: "60640")
property_manager = PropertyManager.create(name: "tom", phone: "773-606-6186", email: "tom@tom.com", address_id: address1.id)
house = user.houses.create(name: "The Hater House", address_id: address2.id, property_manager_id: property_manager.id)
rule = Rule.create(content: "Flush the toilet", housing_assignment_id: 1)
chore = Chore.create(task: "Do the dishes", house_id: 1)
user.chores.create(task: "Mop the floor", house_id: 1)
event = Event.create(name: "Halloween Party", date: "2013-09-12 22:49:27", description: "Costume party!!", housing_assignment_id: 1)
communal_item = CommunalItem.create(name: "toilet paper", brand: "charmin", quantity: 12, house_id: 1, stock_level: "low")
message = Message.create(content: "You're the best!!", picture_url:"http://www.geekbinge.com/wp-content/uploads/2014/02/Space-Jam-2.jpg", housing_assignment_id: 1)
chore_issue = chore.issues.create(reason: "I HATE PAUL!!", user_id: 1)
item_issue = communal_item.issues.create(reason: "I hate paper towel", user_id: 1)
event_issue = event.issues.create(reason: "I hate halloween", user_id: 1)
rule_issue = rule.issues.create(reason: "I hate flushing!!", user_id: 1)
chore_promise_true = chore.user_promises.create(user_id: 1, fulfilled: true)
chore_promise_false = chore.user_promises.create(user_id: 1)
communal_item.user_promises.create(user_id: 1)
communal_item.user_promises.create(user_id: 1, fulfilled: true)
