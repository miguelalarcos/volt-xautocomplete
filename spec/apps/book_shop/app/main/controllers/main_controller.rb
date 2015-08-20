# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    def index
      # Add code for when the index view is loaded
      
      #store._books.destroy_all
      #store._authors.destroy_all
      #p 'before'
      #p store._books.reverse.each(&:destroy)
      #p 'middle'
      #p store._authors.reverse.each(&:destroy)
      #p 'after'

      #store._authors.count.then do |c|
      #  p c
      #end

      #['Dennet', 'Dawkins', 'Darwin'].each do |surname|
      #    store._authors << Author.new({:surname => surname})
      #end
      #store._authors.where({:surname => 'Dawkins'}).first.then do |author|
      #  book = Book.new({:title => 'The selfish gen.', :author => author, :coauthor => 'Darwin'})
      #  store._books << book
      #  p book
      #  self.model = book
      #end
      self.model = store._books.first #Book.new  #({:title => 'The origin of species'}, :author => nil, :coauthor => 'unknown')
    end

    def about
      # Add code for when the about view is loaded
    end

    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
