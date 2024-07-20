module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);
    // Control logic for ringer
    assign ringer = ring & !vibrate_mode;

    // Control logic for motor
    assign motor = ring & vibrate_mode;
endmodule
