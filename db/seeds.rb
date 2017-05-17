# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([{ name: "Walter White", username: "Heisenberg", email: "savewalterwhite@gmail.com", bio: "Jackson Isai? Tu quoque ... A te quidem a ante. Vos scitis quod blinking res Ive 'been vocans super vos? Et conteram illud", password: "123456", password_confirmation: "123456" }, { name: "Jesse Pinkman", username: "CapnCook", email: "jessepinkman@gmail.com", bio: "Ludum mutavit. Verbum est ex. Et", password: "123456", password_confirmation: "123456" }, { name: "Skyler White", username: "whitebitch", email: "skylerwhite@gmail.com", bio: "sunt occidat. Videtur quod est super omne oppidum.", password: "123456", password_confirmation: "123456" }, { name: "Mike Ehrmantraut", username: "mike", email: "mike@gmail.com", bio: "", password: "123456", password_confirmation: "123456" }, { name: "Saul Goodman", username: "SlippinJimmy", email: "bettercallsaul@gmail.com", bio: "Hey, I just talked you down from a death sentence to a six months' probation. I'm the best lawyer ever", password: "123456", password_confirmation: "123456" }])


for i in 1..5
	for j in 1..5
		if i == j
			next
		end
		Follow.create(follower_id: i, following_id: j)
	end
end

tweets = Tweet.create([{ body: "Suus satis. Quod etiam optime. Vos ite post eum, fistulae, nunquam vivum exire ab ea. Sed cum hoc", user_id: 1, created_at: Time.now }, { body: " excidit tibi in cibo aut in potu, aut: olefac Elegantioris non sit ... triginta sex horae post", user_id: 2, created_at: Time.now }, { body: "Poof. Vir aetatis operantes, dura sicut facit ... nemo mirabatur. Mike suspectas habere possunt, sed quod omnes illi eris.", user_id: 3, created_at: Time.now }, { body: "Obsecro, unum homicidam maniaco tempore. ", user_id: 4, created_at: Time.now }, { body: "Ecce dabo Pinkman Isai OK? Sicut locutus est tibi, et datus est, et hic sine Semper consequat volumus", user_id: 5, created_at: Time.now }, { body: "et ille in urbe ista licet? Et infernus, ubi tu non Virginiae ornare vel ipsum.", user_id: 1, created_at: Time.now }, { body: "Ut enim Albuquerque et ille eum iure hic, et ego ducam te ad iustitiam. Quid dicis? ", user_id: 2, created_at: Time.now }, { body: "At nolo de me ipso turpis. Ut nullam curae. Scis quid mihi quod infernum sit amet nunc magis animum, nunc eros eget quam cogitatione", user_id: 3, created_at: Time.now }, { body: " Purus? Sic, si fieri justi ... amabo. ", user_id: 4, created_at: Time.now }, { body: "Prohibere. Striga! Ut custodiant te sermonem dicens - periculi", user_id: 5 }, { body: "periculo! Non ego illud numquam. Dixi sunt implicatae. Elatus deinde manubrio!", user_id: 1, created_at: Time.now }, { body: "Gus sit amet suum motum. Nescio quando, aut quomodo, nescio quo.", user_id: 5, created_at: Time.now } ])