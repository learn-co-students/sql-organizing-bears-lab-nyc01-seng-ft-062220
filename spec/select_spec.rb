describe 'querying the bears table' do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_create_file
    @sql_runner.execute_data
  end
  after do
    File.open('lib/sql', 'w'){ |f| f.truncate(0) }
  end

  it 'selects all of the female bears and returns their name and age' do
    expect(@db.execute(selects_all_female_bears_return_name_and_age)).to eq([["Coco", 21],["Blue", 3], ["Niner", 10],["Wutang", 5]])
  end

  it 'selects all of the bears names and orders them in alphabetical order' do
    expect(@db.execute(selects_all_bears_names_and_orders_in_alphabetical_order)).to eq([[nil],["Blue"],["Coco"],["Niner"],["Pickles"],["Porky"],["Ranger"],["Wutang"]])
  end

  it 'selects all of the bears names and ages that are alive and order them from youngest to oldest' do
    expect(@db.execute(selects_all_bears_names_and_ages_that_are_alive_and_order_youngest_to_oldest)).to eq([["Pickles", 9], ["Niner", 10], ["Ranger", 17], ["Porky", 19], ["Coco", 21]])
  end

  it 'selects the oldest bear and returns their name and age' do
    expect(@db.execute(selects_oldest_bear_and_returns_name_and_age)).to eq([["Coco", 21]])
  end

  it 'selects the youngest bear and returns their name and age' do
    expect(@db.execute(select_youngest_bear_and_returns_name_and_age)).to eq([["Blue", 3]])
  end

  it 'selects the most prominent color and returns it with its count' do
    expect(@db.execute(selects_most_prominent_color_and_returns_with_count)).to eq([["Black", 5]])
  end

  it 'counts the number of bears with goofy temperaments' do
    expect(@db.execute(counts_number_of_bears_with_goofy_temperaments)).to eq([[0]])
  end

  it 'selects the bear that killed Tim' do
    expect(@db.execute(selects_bear_that_killed_Tim)).to eq([[8, nil, 20, "M", "Black", "Lazy", 0]])
  end
end
