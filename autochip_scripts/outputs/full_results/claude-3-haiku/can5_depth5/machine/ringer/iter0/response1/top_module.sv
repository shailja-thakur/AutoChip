module top_module(
    input ring,
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    if (ring && !vibrate_mode) begin
        ringer = 1'b1;
        motor = 1'b0;
    end else if (ring && vibrate_mode) begin
        ringer = 1'b0;
        motor = 1'b1;
    end else begin
        ringer = 1'b0;
        motor = 1'b0;
    end
end

endmodule
