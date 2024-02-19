class LinksController < ApplicationController

      def show
            @link = Link.find_by_lookup_code(params[:lookup_code])

      end

      def create
            shortener = Shortener.new(link_params[:original_url])
            @link = shortener.generate_short_link

            if @link.persisted?
                  respond_to do |format|
                    format.html { redirect_to link_path(@link.lookup_code) }
                  end
            else
                  render 'home/index'
            end

      end

      private

      def link_params
            params.require(:link).permit(:original_url)
      end


end
