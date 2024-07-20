module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d; // input to D flops

// D flop 0
reg d0;
always @(posedge clk, negedge resetn)
    if (~resetn)
        d0 <= 1'b0;
    else
        d0 <= in;

// D flop 1
reg d1;
always @(posedge clk, negedge resetn)
    if (~resetn)
        d1 <= d0;
    else
        d1 <= d[0];

// D flop 2
reg d2;
always @(posedge clk, negedge resetn)
    if (~resetn)
        d2 <= d1;
    else
        d2 <= d[1];

// D flop 3
reg d3;
always @(posedge clk, negedge resetn)
    if (~resetn)
        d3 <= d2;
    else
        d3 <= d[2];

always @(posedge clk)
    if (~resetn)
        d <= 4'b0;
    else
        d <= {d3, d2, d1, d0};

assign out = d[3];
endmodule
