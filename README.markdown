# SCAR

SproutCore add-on frameworks such as BulkApi handle the conversion and binding of `belongs_to` associtions but do not handle the inverse relationships.

For example, BulkApi will map `todo.project_id` to a `Project` object but will not create the inverse association, mapping `project.todos` to an array of IDs (i.e. `project.todos #=> [1, 2, 7]`).

In order to create this inverse association, we simply need to tell the data source to return the IDs of any associated records. This is what SCAR does.

SCAR extends `ActiveRecord`'s `as_json` method to tell your model to return these association IDs:

    ninja_chores = Project.create :name => "Ninja Chores"

    Todo.create(:name => "Wax bo staff", :project => ninja_chores)
    Todo.create(:name => "Order Pizza", :project => ninja_chores)

    project.as_json #=> { :id => 1, :name => "Ninja Chores", :todo_ids => [1, 2] }

This works just as well for `has_one` associations:

    Owner.create(:name => "Donatello", :project => ninja_chores)

    project.as_json #=> { :id => 1, :name => "Ninja Chores", :todo_ids => [1, 2], :owner_id => 9 }

### Usage

Currently this is just a simple drop-in lib for Rails 3.

1. Clone and copy `scar.rb` to `#{Rails.root}/lib`.
1. You'll need to call `require "#{RAILS_ROOT}/lib/scar.rb"` in either `environment.rb` or add this line to an initializer (e.g. `#{Rails.root}/config/initializers/scar.rb`)

This will eventually become a gem with more flexibility.

Pull requests are certainly welcome.


### License

MIT License, of course.