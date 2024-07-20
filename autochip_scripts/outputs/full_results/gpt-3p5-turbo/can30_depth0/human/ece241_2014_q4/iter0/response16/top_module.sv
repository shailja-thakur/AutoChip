module top_module (
	input clk,
	input x,
	output z
);
	// Define the D flip-flops
	reg d_ff1, d_ff2, d_ff3;
	
	// Define the intermediate signals
	wire xor_out, and_out, or_out;
	
	// Connect the input x to the gates
	xor xor_gate (.a(x), .b(d_ff1), .z(xor_out));
	and and_gate (.a(x), .b(~d_ff2), .z(and_out));
	or or_gate (.a(x), .b(~d_ff3), .z(or_out));
	
	// Connect the flip-flop outputs to the XNOR gate
	xnor xnor_gate (.a(xor_out), .b(and_out), .c(or_out), .z(z));
	
	// Clock the flip-flops
	always@(posedge clk) begin
		d_ff1 <= xor_out;
		d_ff2 <= ~d_ff2;
		d_ff3 <= ~d_ff3;
	end
endmodule
module xor (
	input a,
	input b,
	output z
);
	assign z = a ^ b;
endmodule
module and (
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
module or (
	input a,
	input b,
	output z
);
	assign z = a | b;
endmodule
module xnor (
	input a,
	input b,
	input c,
	output z
);
	assign z = ~(a ^ b ^ c);
endmodule
