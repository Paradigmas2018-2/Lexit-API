defmodule LexitApiWeb.ProjectController do
  use LexitApiWeb, :controller

  alias LexitApi.Lexit
  alias LexitApi.Lexit.Project

  action_fallback LexitApiWeb.FallbackController

  def replace_word(to_replace, lexicon, link) when to_replace == lexicon do
    ["[#{to_replace}](#{link})"]
  end
  def replace_word(to_replace, lexicon, link) do
    ["#{to_replace}"]
  end

  def process_text([], lexicon, link) do
    []
  end
  def process_text(array, lexicon, link) do
    hd(array)
    |> replace_word(lexicon, link)
    |> (&(Kernel.++(&1, process_text(tl(array), lexicon, link)))).()
  end

  def convert_text(conn, %{"data" => data}) do
    converted_data = %{
      :final_text => "",
      :original_text => "",
      :lexicon => "",
      :link => ""
    }

    # Mapping JSON data to local variable

    converted_data = data
    |> Map.get("lexicon")
    |> Map.get("name")
    |> (&(put_in(converted_data.lexicon, &1))).()

    converted_data = data
    |> Map.get("lexicon")
    |> Map.get("link")
    |> (&(put_in(converted_data.link, &1))).()

    converted_data = data
    |> Map.get("text")
    |> Map.get("content")
    |> (&(put_in(converted_data.original_text, &1))).()

    list_of_words = String.split(converted_data[:original_text])

    # Using custom made function

    converted_data = process_text(list_of_words, converted_data[:lexicon], converted_data[:link])
      |> Enum.join(" ")
      |> (&(put_in(converted_data.final_text, &1))).()

    # Using String.replace

    # converted_data = String.replace(
    #   converted_data[:original_text],
    #   converted_data[:lexicon],
    #   "[#{converted_data[:lexicon]}](#{converted_data[:link]})")
    #   |> (&(put_in(converted_data.final_text, &1))).()

    render(conn, "convert_text.json", result: converted_data[:final_text])
  end
end
