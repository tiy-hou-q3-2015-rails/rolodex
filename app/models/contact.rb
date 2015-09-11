class Contact
  attr_accessor :id, :first_name, :last_name, :company_name,
    :address, :city, :county, :state, :zip, :phone1,
    :phone2, :email, :web

  def full_name
    [@last_name, @first_name].join(", ")
  end

  def image_name
    if @id.odd?
      "bob.png"
    else
      "clippy.png"
    end
  end

end
