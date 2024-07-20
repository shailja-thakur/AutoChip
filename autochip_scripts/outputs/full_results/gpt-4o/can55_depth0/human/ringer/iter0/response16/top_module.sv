module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);
    // Declare internal signal to indicate phone should ring or not
    wire ringer_on = ring & ~vibrate_mode;
    wire motor_on = ring & vibrate_mode;

    assign ringer = ringer_on;
    assign motor = motor_on;

endmodule
