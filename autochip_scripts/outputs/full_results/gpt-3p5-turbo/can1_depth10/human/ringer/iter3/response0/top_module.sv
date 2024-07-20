module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    ringer = 0;
    motor = 0;
    if (vibrate_mode == 1)
        motor = 1;
    else if (ring == 1)
        ringer = 1;
end

endmodule
