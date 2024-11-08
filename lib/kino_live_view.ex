defmodule KinoLiveView do
  @moduledoc """
  """

  use Kino.JS

  @port Application.compile_env!(:kino_live_view, KinoLiveView.Endpoint)[:http][:port]

  def new(heex) do
    Kino.JS.new(__MODULE__, html(heex))
  end

  defp html(heex) do
    heex
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.safe_to_string()
  end

  asset "main.js" do
    """
    export function init(ctx, html) {
      const liveView = "http://localhost:#{@port}/kino-live-view";
      const ifrm = document.createElement("iframe");

      ifrm.setAttribute("id", "kino-live-view");
      ifrm.setAttribute("src", liveView);

      ifrm.style.border = "0";

      ifrm.style.maxHeight = "500px";
      ifrm.style.overflow = "scroll";
      ifrm.style.width = "100%";

      ctx.root.appendChild(ifrm);

      ifrm.onload = () => {
        ifrm.contentWindow.postMessage(html, liveView);
      };
    }
    """
  end
end
