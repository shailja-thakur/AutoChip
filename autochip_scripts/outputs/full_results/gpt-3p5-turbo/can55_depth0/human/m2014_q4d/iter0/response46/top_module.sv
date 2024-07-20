module top_module (
	input clk,
	input in,
	output logic out
);

// Declare the D flip-flop
reg d;
always_ff @(posedge clk)
    d <= in ^ out;

// Declare the output flip-flop
always_ff @(posedge clk)
    out <= d;
    
endmodule
