class CreativesController < ApplicationController
layout 'creative'
  def index
    @disable_nav = true
  end
end
