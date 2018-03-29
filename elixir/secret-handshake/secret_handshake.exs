defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    events = ["wink", "double blink", "close your eyes", "jump"]

    if code >= 32 || code == 0 do
      []
    else
      case code do
        1 -> [Enum.at(events, 0)]
        2 -> [Enum.at(events, 1)]
        4 -> [Enum.at(events, 2)]
        8 -> [Enum.at(events, 3)]
        _ ->
          code_binary_reversed_array = Enum.reverse(Integer.digits(code, 2))

          Enum.reduce(
            0..(Enum.count(code_binary_reversed_array)-1)
            |> Enum.to_list,
            [],
            fn(index, acc) ->
              if Enum.at(code_binary_reversed_array, index) == 1 do
                if index == 4 && Enum.count(code_binary_reversed_array) === 5 do
                  Enum.reverse(acc)
                else
                  acc ++ [Enum.at(events, index)]
                end
              else
                acc
              end
            end
          )
      end
    end
  end
end
