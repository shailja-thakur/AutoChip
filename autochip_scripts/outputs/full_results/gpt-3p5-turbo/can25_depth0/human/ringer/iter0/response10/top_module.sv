module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

// Declare internal signal wire
wire turn_on_ringer;
wire turn_on_motor;

// Logic to determine whether to turn on the ringer or the motor
assign turn_on_ringer = ~vibrate_mode & ring;
assign turn_on_motor = vibrate_mode & ring;

// Drive the output signals
assign ringer = turn_on_ringer;
assign motor = turn_on_motor;

endmodule
