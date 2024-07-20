module top_module(
    input wire ring,
    input wire vibrate_mode,
    output wire ringer,
    output wire motor
);

// Assign ringer and motor outputs based on the input conditions
always @ (ring, vibrate_mode)
begin
    if (vibrate_mode)
    begin
        ringer <= 0;
        motor <= 1;
    end
    else
    begin
        ringer <= 1;
        motor <= 0;
    end
end

endmodule
