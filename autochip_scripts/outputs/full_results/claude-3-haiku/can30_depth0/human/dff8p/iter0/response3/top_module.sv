module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

always @(negedge clk) begin
    if (reset)
        q <= 8'd52; // Reset the DFFs to 0x34 (decimal 52)
    else
        q <= d;
end

endmodule
