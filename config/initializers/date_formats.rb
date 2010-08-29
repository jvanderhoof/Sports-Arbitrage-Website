ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
	:date => '%m/%d/%Y',
	:game_title => "%A, %B %d, %Y @ %l:%M %p ET",
	:game_line => "%b %d, %l:%M %p",
	:arb_time => "%b %d, %l:%M:%S %p",
	:date_time12  => "%m/%d/%Y %I:%M%p",
	:date_time24  => "%m/%d/%Y %H:%M"
)
