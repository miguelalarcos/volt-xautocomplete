require 'spec_helper'

describe 'sample integration test', type: :feature do
  dawkins = nil
  darwin = nil
  selfish = nil

  before(:each) do
    author = Author.new({:surname => 'Dawkins'})
    dawkins = author
    Volt.current_app.store._authors << author
    Volt.current_app.store._authors << Author.new({:surname => 'Dennet'})
    darwin = Author.new({:surname => 'Darwin'})
    Volt.current_app.store._authors << darwin
    book = Book.new({:title => 'The selfish gen.', :author => dawkins, :coauthor => 'Dawkins'})
    Volt.current_app.store._books << book
    selfish = book
  end 

  it 'should enter A' do
    visit '/' 
    
    find('.first .autocomplete input').set('A')
    find('.first .autocomplete input').trigger('focus')        
    has = find('.first .autocomplete').has_selector? '.autocomplete-popover'
    expect(has).to be_falsey  
  end  

  it 'should enter D' do
    visit '/' 
    
    find('.first .autocomplete input').set('D')
    find('.first .autocomplete input').trigger('focus')        
    has = find('.first .autocomplete').has_selector? '.autocomplete-popover'
    expect(has).to be_truthy  
  end  

  it 'should enter Darw and click' do
    visit '/' 

    find('.first .autocomplete input').set('Darw')
    find('.first .autocomplete input').trigger('focus')        
    find('.autocomplete-popover .item').trigger('click')
    
    value = find('.first .autocomplete input').value
    expect(value).to eq('Darwin')
    has = find('.first .autocomplete').has_selector? '.autocomplete-popover'
    expect(has).to be_falsey  
    expect(selfish.author.value).to be(darwin)
  end  

  it 'should enter D and click' do
    visit '/' 
    
    find('.first .autocomplete input').set('D')
    find('.first .autocomplete input').trigger('focus')        
    find('.autocomplete-popover .item.selected').trigger('click')
    
    value = find('.first .autocomplete input').value
    expect(value).to eq('Darwin')
    has = find('.first .autocomplete').has_selector? '.autocomplete-popover'
    expect(has).to be_falsey      
    expect(selfish.author.value).to be(darwin)
  end  

  it 'should enter A in .second' do
    visit '/' 
    
    find('.second .autocomplete input').set('A')
    find('.second .autocomplete input').trigger('focus')        
    has = find('.second .autocomplete').has_selector? '.autocomplete-popover'
    
    expect(has).to be_falsey  
  end  

  it 'should enter D in .second' do
    visit '/' 
    
    find('.second .autocomplete input').set('D')
    find('.second .autocomplete input').trigger('focus')        
    has = find('.second .autocomplete').has_selector? '.autocomplete-popover'
    
    expect(has).to be_truthy
  end 

  it 'should enter Darw and click in .second' do
    visit '/' 

    find('.second .autocomplete input').set('Darw')
    find('.second .autocomplete input').trigger('focus')        
    find('.autocomplete-popover .item').trigger('click')
    
    value = find('.second .autocomplete input').value
    expect(value).to eq('Darwin')
    has = find('.second .autocomplete').has_selector? '.autocomplete-popover'
    expect(has).to be_falsey  
    expect(selfish.coauthor).to eq('Darwin')
  end  

  it 'should enter D and click in .second' do
    visit '/' 
    
    find('.second .autocomplete input').set('D')
    find('.second .autocomplete input').trigger('focus')                    

    find('.autocomplete-popover .item.selected').trigger('click')
    value = find('.second .autocomplete input').value
    expect(value).to eq('Darwin')
    has = find('.second .autocomplete').has_selector? '.autocomplete-popover'
    expect(has).to be_falsey      
    expect(selfish.coauthor).to eq('Darwin')    
  end  

end
