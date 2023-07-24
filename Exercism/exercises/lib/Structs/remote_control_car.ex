defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new(nickname \\ "none") do
    %RemoteControlCar{battery_percentage: 100, distance_driven_in_meters: 0, nickname: "#{nickname}"}
  end

  def display_distance(%RemoteControlCar{
    battery_percentage: _battery,
    distance_driven_in_meters: distance,
    nickname: _nickname}) do
      "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{
    battery_percentage: battery,
    distance_driven_in_meters: _distance,
    nickname: _nickname}) do
      if battery == 0 do
        "Battery empty"
      else
        "Battery at #{battery}%"
      end
  end

  def drive(%RemoteControlCar{
    battery_percentage: battery,
    distance_driven_in_meters: distance,
    nickname: _nickname} = remote_car) do
      if battery == 0 do
        remote_car
      else
        %{remote_car | battery_percentage: battery - 1, distance_driven_in_meters: distance + 20}
      end
  end
end
