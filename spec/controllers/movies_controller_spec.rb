require 'spec_helper'
describe MoviesController do
  describe 'searching by director' do
    before :each do
      fake_results = [mock('Movie'), mock('Movie')]
    end
    it 'should call the modelmethod that performs search by direcotr' do
      Movie.should_receive(:find_by_director).with('George Lucas').and_return(fake_results)
      post :search_by_director, {:search_terms => 'George Lucas'}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(fake_results)
        post :search_by_director, {:search_terms => 'George Lucas'}
      end
      it 'should select the Search Results tamplate for rendering'
        response.should render_template('search_results')
      end
      it 'should make hte results search available to that template'
        assigns(:movies).should == @fake_results
      end
    end
  end
end
