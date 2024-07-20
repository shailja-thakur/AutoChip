module top_module (
	input clk,
	input x,
	output z
);
	reg [2:0] flip_flops;
	wire [2:0] flip_flop_outputs;
	wire z;
	
	xor_gate xor_gate_inst (.a(flip_flops[0]), .b(x), .z(flip_flop_outputs[0]));
	and_gate and_gate_inst (.a(flip_flops[1]), .b(~flip_flops[1]), .z(flip_flop_outputs[1]));
	or_gate or_gate_inst (.a(flip_flops[2]), .b(~flip_flops[2]), .z(flip_flop_outputs[2]));
	xnor_gate xnor_gate_inst (.a(flip_flop_outputs[0]), .b(flip_flop_outputs[1]), .c(flip_flop_outputs[2]), .z(z));
	
	always @(posedge clk) begin
		flip_flops <= x;
	end
endmodule
module xor_gate (
	input a,
	input b,
	output z
);
	assign z = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
module or_gate (
	input a,
	input b,
	output z
);
	assign z = a | b;
endmodule
module xnor_gate (
	input a,
	input b,
	input c,
	output z
);
	assign z = ~(a ^ b ^ c);
endmodule
