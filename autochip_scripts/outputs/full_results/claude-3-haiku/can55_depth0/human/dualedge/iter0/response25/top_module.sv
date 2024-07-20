module top_module(
    input clk,
    input d,
    output reg q
);

wire clk_posedge, clk_negedge;

// Detect rising and falling edges of the clock signal
assign clk_posedge = clk & ~clk_negedge;
assign clk_negedge = ~clk & clk;

// Dual-edge triggered flip-flop using two D-flip-flops
always @(posedge clk_posedge) begin
    q <= d;
end

always @(posedge clk_negedge) begin
    q <= d;
end

endmodule
