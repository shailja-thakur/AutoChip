module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

    /* Control the ringer and motor outputs */
    always @* begin
        ringer = ring & ~vibrate_mode; // Set ringer output to 1 when ring=1 and vibrate_mode=0
        motor = ring & vibrate_mode; // Set motor output to 1 when ring=1 and vibrate_mode=1
    end

endmodule
