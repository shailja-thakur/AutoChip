module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    if (vibrate_mode) begin
        ringer = 0; // Turn off ringer
        motor = 1; // Turn on motor
    end
    else if (ring) begin
        ringer = 1; // Turn on ringer
        motor = 0; // Turn off motor
    end
    else begin
        ringer = 0; // Turn off ringer
        motor = 0; // Turn off motor
    end
end

endmodule
