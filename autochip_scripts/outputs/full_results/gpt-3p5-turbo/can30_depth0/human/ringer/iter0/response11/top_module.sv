module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // Declare internal signals
    wire ringer_on;
    wire motor_on;

    // Control logic
    assign ringer_on = (vibrate_mode) ? 0 : ring;
    assign motor_on = (vibrate_mode) ? 1 : ~ring;

    // Output assignments
    assign ringer = ringer_on;
    assign motor = motor_on;

endmodule
