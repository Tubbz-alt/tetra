  # encoding: UTF-8

module Gjp
  # encapsulates details of a package needed by the spec file
  # retrieving them from other objects
  class PackageSpecAdapter
    attr_reader :name
    attr_reader :version
    attr_reader :license
    attr_reader :summary
    attr_reader :url
    attr_reader :project_name
    attr_reader :group_id
    attr_reader :artifact_id
    attr_reader :version
    attr_reader :runtime_dependency_ids
    attr_reader :description
    attr_reader :outputs

    def initialize(project, package_name, pom)
      @name = package_name
      @version = pom.version
      @license = pom.license_name
      clean_description = pom.description.gsub(/[\s]+/, ' ').strip
      @summary = clean_description[0..60].gsub(/\s\w+$/, '...')
      @url = pom.url
      @project_name = project.name
      @group_id = pom.group_id
      @artifact_id = pom.artifact_id
      @version = pom.version
      @runtime_dependency_ids = pom.runtime_dependency_ids
      @description = clean_description

      output_list = File.join(project.full_path, "file_lists", "#{@name}_output")
      @outputs = File.open(output_list).readlines.map { |line| line.strip }
    end

    def get_binding
      binding
    end
  end
end
