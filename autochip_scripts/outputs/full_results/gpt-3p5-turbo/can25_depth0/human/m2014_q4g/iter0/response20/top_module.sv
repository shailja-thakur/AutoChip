module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	xnor2 #(.N(2)) u1 (.A(in1), .B(in2), .Z(xor_in));

	xor2 u2 (.A(xor_in), .B(in3), .Z(out));

endmodule
module xnor2 (
	input logic [1:0] A,
	input logic [1:0] B,
	output logic [1:0] Z
);

	assign Z[0] = ~(A[0] ^ B[0]);
	assign Z[1] = ~(A[1] ^ B[1]);

endmodule
module xor2 (
	input logic [1:0] A,
	input logic [1:0] B,
	output logic [1:0] Z
);

	assign Z[0] = A[0] ^ B[0];
	assign Z[1] = A[1] ^ B[1];

endmodule
