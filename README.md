# KinoLiveComponent

[![hex version](https://img.shields.io/hexpm/v/kino_live_component.svg)](https://hex.pm/packages/kino_live_component)

This kino allows you to render fully-styled Phoenix function and live components in [Livebook](https://livebook.dev).

## Installation

```elixir
def deps do
  [
    {:kino_live_component, ">= 0.0.0", only: :dev}
  ]
end
```

## Usage

In order to use KinoLiveComponent, you must add an endpoint to your router.

```elixir
  import KinoLiveComponent.Plug, only: [allow_insecure_connection: 2]

  if Mix.env() == :dev do
    scope "/kino-live-component", KinoLiveComponent do
      pipe_through([:allow_insecure_connection])

      live("/", Live.Index)
    end
  end
```

If you use a non-standard asset pipeline or port number or your `app.js` is bonkers, you might need to set config values or compile separate assets:

```elixir
config :kino_live_component,
  css_path: "http://localhost:9999/app.css", # default: http://localhost:4000/assets/app.css
  endpoint: "http://localhost:9999/kino-live-component", # default http://localhost:4000/kino-live-component
  js_path: "http://localhost:9999/app.js" # default http://localhost:4000/assets/app.js
```

Then, connect your Livebook to your running application.

### Function components

To create a function component in Livebook:

```elixir
import Phoenix.Component, only: [sigil_H: 2]

assigns = %{
  content: "I am a function component being rendered in a Phoenix application."
}

~H"""
<div class="p-3 bg-orange-500 text-white">
  <%= @content %>
</div>
""" |> KinoLiveComponent.component()
```

### Live components

```elixir
map_config = Application.get_env(:mbta_metro, :map)

assigns = %{
  class: "h-96 w-full",
  config: map_config
}

KinoLiveComponent.component(MbtaMetro.Live.Map, assigns)
```