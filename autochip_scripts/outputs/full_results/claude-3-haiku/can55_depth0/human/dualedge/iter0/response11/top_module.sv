module top_module(
    input clk,
    input d,
    output reg q
);

wire clkPosEdge, clkNegEdge;

// Generate positive and negative edge clock signals
assign clkPosEdge = clk & ~clk;
assign clkNegEdge = ~clk & clk;

// Dual-edge triggered flip-flop logic
always @(posedge clkPosEdge or posedge clkNegEdge) begin
    if (clkPosEdge)
        q <= d;
    else if (clkNegEdge)
        q <= d;
end

endmodule
