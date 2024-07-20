module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    if (vibrate_mode) begin
        ringer = 0;
        motor = 1;
    end
    else begin
        ringer = ring;
        motor = ~ring;
    end
end

endmodule
module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    if (vibrate_mode) begin
        ringer = 0;
        motor = 1;
    end
    else begin
        ringer = ring;
        motor = ~ring;
    end
end

endmodule
