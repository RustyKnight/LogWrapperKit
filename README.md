#LogWrapperKit
The intention is to provide a unified API around the basic concept of logging, where the underlying implementation is
unimportant to the people using the API, who are only concerned with generating some kind of logging output during the 
development process.

The API provides a simplified interface of methods, which reduces the typing and supports, in many places `Error` and `CustomStringConvertable`
as well as `String` messages.

The API provides a delegation approach to allow it to be plugged into other logging services easily, without otherwise
effecting the rest of the code
