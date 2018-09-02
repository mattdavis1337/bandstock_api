defmodule BandstockAPI.TileImage do
  use Arc.Definition
  use Arc.Ecto.Definition
  def __storage, do: Arc.Storage.Local

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:thumb, _), do: :public_read

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  #def transform(:thumb, _) do
  #  {:convert, "-thumbnail 100x100^ -gravity center -extent 100x100 -format png", :png}
  #end

  def filename(version, {file, scope}) do
    #IO.puts("version: " <> version);
    #IO.puts("file: " <> file);
    #IO.puts("scope: " <> scope);
    #file_name = Path.basename(file.file_name, Path.extname(file.file_name))
    #IO.puts("file_name: " <> file_name);
    IO.puts("*****In filename/2*****")
    IO.inspect(file);
    IO.inspect(scope);
    "#{random_string(8)}"
    #{}"#{scope.id}_#{version}_#{file_name}_"
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  def storage_dir(_, {file, user}) do
    IO.puts("in storage_dir");
    IO.inspect(file);
    IO.inspect(user)
    "priv/static/uploads/tileimages/"
  end
end
