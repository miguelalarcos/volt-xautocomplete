module Xautocomplete
  class Data
    attr_reader :obj, :text
    def initialize(obj, text)
      @obj = obj
      @text = text
    end  
  end

  class MainController < Volt::ModelController

    reactive_accessor :index_  
    reactive_accessor :query  
    reactive_accessor :focus

    def val_f
      self.query
    end

    def val_f=(val)
      self.query = val
      name = attrs.field 
      collection = attrs.collection 
      dct = {}
      dct[name] = val
      order_ = {}
      order_[name] = 1

      #attrs.value = nil # gives me an error of method 'id' not found
      
      collection.where(dct).order(order_).first.then do |x|
        if not x.nil?
          if attrs.reference
            attrs.value = x      
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
      autocomplete.first.value and autocomplete.first.value.text != self.query
    end 

    def click_item data
      self.query=data.text
      if attrs.reference
        attrs.value=data.obj
      else
        attrs.value=data.text
      end
    end

    def down e            
      if e.key_code == 38
        self.index_ -= 1
      elsif e.key_code == 40
        self.index_ += 1
      elsif e.key_code == 13
        name = attrs.field 
        collection = attrs.collection 
        dct = {}
        dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
        order_ = {}
        order_[name] = 1

        collection.where(dct).order(order_).all.then do |r|
          count = r.count.value
          self.query = r[self.index_ % count].send(name).value
          if attrs.reference
            attrs.value = r[self.index_ % count].value
          else
            attrs.value = r[self.index_ % count].send(name).value
          end  
        end
      end  
    end

    def selected? i
      name = attrs.field 
      collection = attrs.collection 
      dct = {}
      dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
      collection.where(dct).count.then do |c|
        if self.index_ % c == i
          'xselected'
        else
          ''
        end
      end
    end

    def autocomplete
      name = attrs.field 
      collection = attrs.collection 
      dct = {}
      dct[name] = {"$regex" => '^.*' + self.query + '.*$'}
      order_ = {}
      order_[name] = 1
      collection.where(dct).order(order_).all.collect {|x| Data.new(x, x.send(name) ) }
    end  

    def index
      attrs.value.then do |x|
        if attrs.reference
          name = attrs.field          
          self.query = x.send(name)    
        else
          self.query = x
        end
      end
      self.index_ = 0       
    end
  end
end
