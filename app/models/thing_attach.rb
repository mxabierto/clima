class ThingAttach < ActiveRecord::Base
  belongs_to :thing
  attachment :file#, content_type: ["image/jpeg", "image/png", "image/gif", "application/pdf"]

  after_destroy :remove_file

  private

  def remove_file
    file.delete
  end
end
