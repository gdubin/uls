require 'zip'

module ULS
  # Used to interact with the FCC 'database' files.  These files are compressed
  # files containing several individual pipe-delimited data files.
  class Database
    attr_accessor :compressed_file

    # Use to construct an interface to the Database zipfile/directory
    # retrieved from the FCC.  The filename may either be a zip file,
    # in which case it will be extracted to the temporary directory, or
    # may be an already extract directory containing the various 'database'
    # files.
    def initialize(filename)
      path = Pathname.new(filename)
      if path.directory?
        @extracted_path = filename
      else
        @compressed_file = filename
      end
    end

    def name_and_addresses
      extract unless extracted?

      DatFile.new("#{extracted_path}/EN.dat")
    end

    def form_primary
      extract unless extracted?

      DatFile.new("#{extracted_path}/HD.dat")
    end

    def form_secondary
      extract unless extracted?

      DatFile.new("#{extracted_path}/AD.dat")
    end

    def extracted_path
      @extracted_path ||= "#{ULS.configuration.tmpdir}/uls_#{Time.now.to_i}"
    end

    def extracted?
      Dir.exist?(extracted_path)
    end

    def extract
      FileUtils.mkdir_p(extracted_path)
      Zip::File.open(compressed_file) do |opened_file|
        opened_file.each do |entry|
          entry.extract("#{extracted_path}/#{entry.name}")
        end
      end
    end

    def clean
      File.rmdir(extracted_path)
    end

    def delete
      File.delete(compressed_file)
    end

    def delete!
      clean if extracted?

      delete
    end
  end
end
