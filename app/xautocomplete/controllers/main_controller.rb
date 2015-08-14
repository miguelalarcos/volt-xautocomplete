module Xautocomplete
  class MainController < Volt::ModelController

    reactive_accessor :index_  
    reactive_accessor :query  
    reactive_accessor :focus

    def val_f
      if self.query.blank? and attrs.value
        if attrs.reference
          name = attrs.field       #
          attrs.value.send('_'+name)   #
        else
          attrs.value
        end
      else
        self.query
      end
    end

    def val_f=(val)
      self.query = val
      name = attrs.field #:value
      collection = attrs.collection # store._authors
      dct = {}
      dct[name] = val
      attrs.value = nil
      collection.where(dct).first.then do |x|
        if not x.nil?
          if attrs.reference
            attrs.value = x      #
          else
            attrs.value = val 
          end  
        end
      end      
    end

    def show    
      if self.query.blank? or not self.focus
        return false
      end
      if attrs.reference
        if autocomplete.first.value and autocomplete.first.value.send('_'+attrs.field) != self.query
          true
        else
          false
        end
      else
        if autocomplete.first.value != self.query
          true
        else
          false
        end
      end
    end 

    def click_(val)
      name = attrs.field
      if attrs.reference
        self.query = val.send('_'+name)
      else
        self.query = val
      end
      attrs.value = val
    end

    def down e            
      if e.key_code == 38
        self.index_ -= 1
        p self.index_
      elsif e.key_code == 40
        self.index_ += 1
      elsif e.key_code == 13
        name = attrs.field #:value
        collection = attrs.collection # store._authors
        dct = {}
        dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
        #ret = collection.where(dct).all.collect {|x| x.send('_'+name)}      
        ret = collection.where(dct).all
        ret.then do |r|
        #collection.where(dct).all do |r|
          count = r.count.value
          self.query = r[self.index_ % count].send('_'+name).value
          if attrs.reference
            attrs.value = r[self.index_ % count].value
          else
            attrs.value = r[self.index_ % count].send('_'+name).value
          end  
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
      if attrs.reference
        collection.where(dct).all
      else
        collection.where(dct).all.collect {|x| x.send('_'+name)}            
      end
    end  

    def index
      # Add code for when the index view is loaded
      self.query = ''
      self.index_ = 0
      
    end

  end
end
