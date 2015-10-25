defmodule IExHelpers do
  def reload! do
    Mix.Task.reenable "compile.elixir"
    Mix.Task.run "compile.elixir"
  end
end

iex = IExHelpers
