module top_module (
	input clk,
	input in,
	output logic out
);

// Declaration of D flip-flop
reg d_ff;
reg q;

// Declaration of XOR gate
wire xor_out;

// D flip-flop
always @(posedge clk)
	begin
		q <= d_ff;
	end

// XOR gate
assign xor_out = in ^ q;

// Assigning output
assign out = xor_out;

endmodule
