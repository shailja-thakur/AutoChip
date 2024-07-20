module top_module (
	input clk,
	input in,
	output logic out
);

// Declare a flip-flop signal
logic flop;

// Sequential process triggered by posedge of clk
always_ff @(posedge clk)
    flop <= flop ^ in;

// Assign flop to out
assign out = flop;

endmodule
