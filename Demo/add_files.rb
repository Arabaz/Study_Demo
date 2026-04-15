require 'xcodeproj'
project_path = 'Demo.xcodeproj'
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

def add_files_to_group(project, target, current_group, current_dir)
  Dir.entries(current_dir).each do |entry|
    next if entry == '.' || entry == '..' || entry.start_with?('.')
    
    path = File.join(current_dir, entry)
    
    if File.directory?(path)
      # Skip if it's an app extension or framework etc. 
      next if path.end_with?('.xcassets', '.xcodeproj', '.xcworkspace', 'Preview Content')
      
      # Find or create group
      group = current_group.groups.find { |g| g.display_name == entry || g.path == entry }
      group ||= current_group.new_group(entry, entry)
      
      add_files_to_group(project, target, group, path)
    elsif path.end_with?('.swift') && entry != 'ContentView.swift' && entry != 'DemoApp.swift'
      # Add file reference if it doesn't exist
      unless current_group.files.any? { |f| f.path == path || f.name == entry || f.path == entry }
        file_ref = current_group.new_file(path)
        target.source_build_phase.add_file_reference(file_ref)
      end
    end
  end
end

main_group = project.main_group.children.find { |g| g.path == 'Demo' || g.name == 'Demo' }
if main_group
    add_files_to_group(project, target, main_group, 'Demo')
    project.save
    puts "Files added and project saved."
else
    puts "Main group 'Demo' not found."
end
