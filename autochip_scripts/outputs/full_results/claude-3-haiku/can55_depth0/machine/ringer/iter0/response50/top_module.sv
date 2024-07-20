module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    // Set the ringer output
    ringer = ring & ~vibrate_mode;

    // Set the motor output
    motor = ring & vibrate_mode;
end

endmodule
