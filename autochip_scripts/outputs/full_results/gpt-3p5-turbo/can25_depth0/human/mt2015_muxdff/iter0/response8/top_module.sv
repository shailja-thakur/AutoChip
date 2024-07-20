module flipflop
(
	input clk,
	input D,
	output reg Q
);

	always @(posedge clk) begin
		Q <= D;
	end

endmodule
module mux2to1
(
	input A,
	input B,
	input S,
	output reg Y
);

	always @(A or B or S) begin
		case(S)
			0: Y <= A;
			1: Y <= B;
		endcase
	end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

	wire q0, q1, q2;
	wire r, D, S;

	assign r = r_in;
	assign D = q0;
	assign S = {q1, q2};

	flipflop ff1(.clk(clk), .D(D), .Q(q0));
	flipflop ff2(.clk(clk), .D(D), .Q(q1));
	flipflop ff3(.clk(clk), .D(D), .Q(q2));
	mux2to1 mux(.A(q0), .B(q2), .S(S), .Y(Q));

	always @(posedge clk) begin
		if (L) begin
			q0 <= r;
		end else begin
			q0 <= {q1 ^ q2, q0, q2};
		end
	end

endmodule
