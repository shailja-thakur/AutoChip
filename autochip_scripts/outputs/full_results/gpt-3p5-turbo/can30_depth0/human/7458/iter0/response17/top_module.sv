module top_module(
	input p1a,
	input p1b,
	input p1c,
	input p1d,
	input p1e,
	input p1f,
	output p1y,
	input p2a,
	input p2b,
	input p2c,
	input p2d,
	output p2y
);

	wire and_gate_output_1;
	wire and_gate_output_2;
	wire and_gate_output_3;
	wire and_gate_output_4;

	assign and_gate_output_1 = p1a & p1b & p1c;
	assign and_gate_output_2 = p1d & p1e & p1f;
	assign and_gate_output_3 = p2a & p2b;
	assign and_gate_output_4 = p2c & p2d;

	assign p1y = and_gate_output_1 | and_gate_output_2;
	assign p2y = and_gate_output_3 | and_gate_output_4;
  
endmodule
