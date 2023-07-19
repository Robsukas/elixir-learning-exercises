defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    noon = ~T[12:00:00]
    time = NaiveDateTime.to_time(datetime)
    time < noon
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 28, :day))
    else
      NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 29, :day))
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    date_difference = Date.diff(planned_return_date, actual_return_date)
    if date_difference >= 0 do
      0
    else
      abs(date_difference)
    end
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    actual_return_datetime = datetime_from_string(return)
    planned_return_date = return_date(checkout_datetime)
    days_late = days_late(planned_return_date, actual_return_datetime)

    late_fee = if days_late == 0 do
      0
    else
      late_fee = days_late * rate
      if monday?(actual_return_datetime) do
        floor(late_fee * 0.5)
      else
        late_fee
      end
    end
    late_fee
  end
end
