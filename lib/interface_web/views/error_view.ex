defmodule InterfaceWeb.ErrorView do
  use InterfaceWeb, :view
  def render("100.json", _assigns), do: %{errors: %{detail: "Continue"}}
  def render("101.json", _assigns), do: %{errors: %{detail: "Switching Protocols"}}
  def render("102.json", _assigns), do: %{errors: %{detail: "Processing"}}
  def render("103.json", _assigns), do: %{errors: %{detail: "Early Hints"}}
  def render("200.json", _assigns), do: %{errors: %{detail: "OK"}}
  def render("201.json", _assigns), do: %{errors: %{detail: "Created"}}
  def render("202.json", _assigns), do: %{errors: %{detail: "Accepted"}}
  def render("203.json", _assigns), do: %{errors: %{detail: "Non-Authoritative Information"}}
  def render("204.json", _assigns), do: %{errors: %{detail: "No Content"}}
  def render("205.json", _assigns), do: %{errors: %{detail: "Reset Content"}}
  def render("206.json", _assigns), do: %{errors: %{detail: "Partial Content"}}
  def render("207.json", _assigns), do: %{errors: %{detail: "Multi-Status"}}
  def render("208.json", _assigns), do: %{errors: %{detail: "Already Reported"}}
  def render("226.json", _assigns), do: %{errors: %{detail: "IM Used"}}
  def render("300.json", _assigns), do: %{errors: %{detail: "Multiple Choices"}}
  def render("301.json", _assigns), do: %{errors: %{detail: "Moved Permanently"}}
  def render("302.json", _assigns), do: %{errors: %{detail: "Found"}}
  def render("303.json", _assigns), do: %{errors: %{detail: "See Other"}}
  def render("304.json", _assigns), do: %{errors: %{detail: "Not Modified"}}
  def render("305.json", _assigns), do: %{errors: %{detail: "Use Proxy"}}
  def render("306.json", _assigns), do: %{errors: %{detail: "Switch Proxy"}}
  def render("307.json", _assigns), do: %{errors: %{detail: "Temporary Redirect"}}
  def render("308.json", _assigns), do: %{errors: %{detail: "Permanent Redirect"}}
  def render("400.json", _assigns), do: %{errors: %{detail: "Bad Request"}}
  def render("401.json", _assigns), do: %{errors: %{detail: "Unauthorized"}}
  def render("402.json", _assigns), do: %{errors: %{detail: "Payment Required"}}
  def render("403.json", _assigns), do: %{errors: %{detail: "Forbidden"}}
  def render("404.json", _assigns), do: %{errors: %{detail: "Not Found"}}
  def render("405.json", _assigns), do: %{errors: %{detail: "Method Not Allowed"}}
  def render("406.json", _assigns), do: %{errors: %{detail: "Not Acceptable"}}
  def render("407.json", _assigns), do: %{errors: %{detail: "Proxy Authentication Required"}}
  def render("408.json", _assigns), do: %{errors: %{detail: "Request Timeout"}}
  def render("409.json", _assigns), do: %{errors: %{detail: "Conflict"}}
  def render("410.json", _assigns), do: %{errors: %{detail: "Gone"}}
  def render("411.json", _assigns), do: %{errors: %{detail: "Length Required"}}
  def render("412.json", _assigns), do: %{errors: %{detail: "Precondition Failed"}}
  def render("413.json", _assigns), do: %{errors: %{detail: "Payload Too Large"}}
  def render("414.json", _assigns), do: %{errors: %{detail: "URI Too Long"}}
  def render("415.json", _assigns), do: %{errors: %{detail: "Unsupported Media Type"}}
  def render("416.json", _assigns), do: %{errors: %{detail: "Range Not Satisfiable"}}
  def render("417.json", _assigns), do: %{errors: %{detail: "Expectation Failed"}}
  def render("418.json", _assigns), do: %{errors: %{detail: "I'm a teapot"}}
  def render("421.json", _assigns), do: %{errors: %{detail: "Misdirected Request"}}
  def render("422.json", _assigns), do: %{errors: %{detail: "Unprocessable Entity"}}
  def render("423.json", _assigns), do: %{errors: %{detail: "Locked"}}
  def render("424.json", _assigns), do: %{errors: %{detail: "Failed Dependency"}}
  def render("426.json", _assigns), do: %{errors: %{detail: "Upgrade Required"}}
  def render("428.json", _assigns), do: %{errors: %{detail: "Precondition Required"}}
  def render("429.json", _assigns), do: %{errors: %{detail: "Too Many Requests"}}
  def render("431.json", _assigns), do: %{errors: %{detail: "Request Header Fields Too Large"}}
  def render("451.json", _assigns), do: %{errors: %{detail: "Unavailable For Legal Reasons"}}
  def render("500.json", _assigns), do: %{errors: %{detail: "Internal Server Error"}}
  def render("501.json", _assigns), do: %{errors: %{detail: "Not Implemented"}}
  def render("502.json", _assigns), do: %{errors: %{detail: "Bad Gateway"}}
  def render("503.json", _assigns), do: %{errors: %{detail: "Service Unavailable"}}
  def render("504.json", _assigns), do: %{errors: %{detail: "Gateway Timeout"}}
  def render("505.json", _assigns), do: %{errors: %{detail: "HTTP Version Not Supported"}}
  def render("506.json", _assigns), do: %{errors: %{detail: "Variant Also Negotiates"}}
  def render("507.json", _assigns), do: %{errors: %{detail: "Insufficient Storage"}}
  def render("508.json", _assigns), do: %{errors: %{detail: "Loop Detected"}}
  def render("510.json", _assigns), do: %{errors: %{detail: "Not Extended"}}
  def render("511.json", _assigns), do: %{errors: %{detail: "Network Authentication Required"}}
end
