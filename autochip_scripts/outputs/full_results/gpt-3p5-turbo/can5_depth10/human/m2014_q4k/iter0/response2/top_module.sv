module top_module(
    input clk,
    input resetn,
    input in,
    output out
);

    wire d1, d2, d3;

    d_ff dff1(.clk(clk), .resetn(resetn), .d(in), .q(d1));
    d_ff dff2(.clk(clk), .resetn(resetn), .d(d1), .q(d2));
    d_ff dff3(.clk(clk), .resetn(resetn), .d(d2), .q(d3));
    d_ff dff4(.clk(clk), .resetn(resetn), .d(d3), .q(out));
    
endmodule
