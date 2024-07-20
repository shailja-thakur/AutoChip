module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

always @(negedge clk) begin
    if (reset)
        q <= 8'h34; // Set to 0x34 on reset
    else
        q <= d;
end

endmodule
