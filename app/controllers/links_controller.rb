class LinksController < ApplicationController

      def create
            shortener = Shortener.new(link_params[:original_url])
            @link = shortener.generate_short_link

            respond_to do |format|
                  if @link.persisted?
                    format.js { render 'create.js.erb' }
                  else
                    format.js { render 'error.js', status: :unprocessable_entity }
                  end
            end

            #if @link.persisted?
            #      respond_to do |format|
            #           format.js
            #            format.html { redirect_to root_path }
            #      end
            #else
            #      render 'home/index'
            #end

      end

      private

      def link_params
            params.require(:link).permit(:original_url)
      end


end
