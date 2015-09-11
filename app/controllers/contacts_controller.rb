require 'csv'
class ContactsController < ApplicationController

  def list
    @contacts = fetch_contacts.sort_by(&:last_name)

    if params[:qs].present?
      @contacts = @contacts.select do |c|
        (c.last_name.downcase.include? params[:qs].downcase) ||
        (c.first_name.downcase.include? params[:qs].downcase) ||
        (c.email.downcase.include? params[:qs].downcase) ||
        (c.company_name.downcase.include? params[:qs].downcase)
      end
    end

  end

  def detail
    @contacts = fetch_contacts
    @contact = @contacts.find {|c| c.id == params[:id].to_i }
  end

  def fetch_contacts

    @contacts = []

    counter = 1

    CSV.foreach(Rails.root + "data/us-500.csv", headers: true) do |row|
      # fill the array

      contact = Contact.new
      contact.id = counter
      contact.first_name = row.to_h["first_name"]
      contact.last_name = row.to_h["last_name"]
      contact.email = row.to_h["email"]
      contact.company_name = row.to_h["company_name"]
      contact.phone1 = row.to_h["phone1"]

      @contacts << contact
      counter += 1
    end

    @contacts
  end

end
