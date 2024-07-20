module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    wire ring_enable;
    wire motor_enable;

    assign ring_enable = ~vibrate_mode;
    assign motor_enable = vibrate_mode;

    assign ringer = ring & ring_enable;
    assign motor = ring & motor_enable;

endmodule
