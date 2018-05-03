if Code.ensure_compiled?(Calendar.DateTime) do
  defmodule Quantum.DateLibrary.Calendar do
    @moduledoc """
    `calendar` implementation of `Quantum.DateLibrary`.

    **This behaviour is considered internal. Breaking Changes can occur on every
    release.**

    ### Installation
      `config.exs`

        config :quantum,
          date_library: Quantum.DateLibrary.Calendar

      `mix.exs`

        defp deps do
          [{:quantum, "*"},
           {:calendar, "*"}]
        end
    """

    @behaviour Quantum.DateLibrary

    alias Calendar.DateTime, as: CalendarDateTime

    @spec utc_to_tz!(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t() | no_return
    def utc_to_tz!(date, tz) do
      date
      |> DateTime.from_naive!("Etc/UTC")
      |> CalendarDateTime.shift_zone!(tz)
      |> DateTime.to_naive()
    end

    @spec tz_to_utc!(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t() | no_return
    def tz_to_utc!(date, tz) do
      {:ok, tz_date} = CalendarDateTime.from_naive(date, tz)

      tz_date
      |> CalendarDateTime.shift_zone!("Etc/UTC")
      |> DateTime.to_naive()
    end

    @spec dependency_application :: :calendar
    def dependency_application, do: :calendar
  end
end
