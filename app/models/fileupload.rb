class Fileupload < ActiveRecord::Base
  belongs_to :user
  validates :file_name, presence: true, length: { minimum: 5 }
  validates :file_path, presence: true

  attr_writer :uploaded_file

  before_destroy do
    File.delete(self.file_path)
  end

  before_validation do
    if not @uploaded_file.nil?
      self.file_name = @uploaded_file.original_filename
      self.file_path = Constants::DevelopmentConstants.uploaded_files_directory+"/"+SecureRandom.urlsafe_base64
      FileUtils.copy_file(@uploaded_file.path, file_path)
    end
  end
end
