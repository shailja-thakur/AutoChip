module top_module(
    input wire ring,
    input wire vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    ringer = (ring && !vibrate_mode);
    motor = (ring && vibrate_mode);
end

endmodule
