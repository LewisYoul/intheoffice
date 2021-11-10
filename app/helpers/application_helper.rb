module ApplicationHelper
  def nav_link_to(path)
    classes = if request.path == path
      "bg-gray-900 text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md"
    else
      "text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md"
    end

    link_to(path, class: classes) do
      yield
    end
  end
end
