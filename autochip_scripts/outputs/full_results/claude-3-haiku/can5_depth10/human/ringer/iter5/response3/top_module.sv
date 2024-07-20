module top_module(
    input ring, 
    input vibrate_mode,
    output wire ringer,
    output wire motor
);

always @(*) begin
    if (vibrate_mode) begin
        ringer = 1'b0;
        motor = 1'b1;
    end
    else if (ring) begin
        ringer = 1'b1;
        motor = 1'b0;
    end
    else begin
        ringer = 1'b0;
        motor = 1'b0;
    end
end

endmodule
