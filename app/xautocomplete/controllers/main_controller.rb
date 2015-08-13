module Xautocomplete
  class MainController < Volt::ModelController

    reactive_accessor :index_  
    reactive_accessor :query  

    def down e            
      if e.key_code == 38
        self.index_ -= 1
        p self.index_
      elsif e.key_code == 40
        self.index_ += 1
      elsif e.key_code
        name = attrs.field #:value
        collection = attrs.collection # store._authors
        dct = {}
        dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
        ret = collection.where(dct).all.collect {|x| x.send('_'+name)}      
        ret.then do |r|
          self.query = r[self.index_ % r.count]
        end
      end  
    end

    def selected? i
      name = attrs.field #:value
      collection = attrs.collection #store._authors
      dct = {}
      dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
      collection.where(dct).count.then do |c|
        if self.index_ % c == i
          'selected'
        else
          ''
        end
      end
    end

    def autocomplete
      name = attrs.field #:value
      collection = attrs.collection #store._authors
      dct = {}
      dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
      collection.where(dct).all.collect {|x| x.send('_'+name)}            
    end  

    def index
      # Add code for when the index view is loaded
      self.query = ''
      self.index_ = 0
      
    end

  end
end
