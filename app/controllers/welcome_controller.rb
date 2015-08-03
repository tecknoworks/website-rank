class WelcomeController < ApplicationController

  api :GET, '', 'Short description example'
  description <<-EOS
    Example response here[/]
  EOS
  def index
  end

end
