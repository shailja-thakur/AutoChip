module top_module (
	input clk,
	input x,
	output z
);
	// Declare D flip-flops
	reg dff1;
	reg dff2;
	reg dff3;
	
	// Declare intermediate signals
	wire xor_out;
	wire and_out;
	wire or_out;
	
	// Declare output wire
	assign z = ~(&xor_out & and_out & or_out);
	
	// Connect inputs to gates
	xor xor_gate (.a(dff1), .b(x), .z(xor_out));
	and and_gate (.a(dff2), .b(~dff2), .z(and_out));
	or or_gate (.a(dff3), .b(~dff3), .z(or_out));
	
	// Connect flip-flop outputs to gates
	always @(posedge clk) begin
		dff1 <= xor_out;
		dff2 <= and_out;
		dff3 <= or_out;
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
