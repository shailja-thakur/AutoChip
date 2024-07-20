module flipflop (
	input clk,
	input D,
	output reg Q
);

always @(posedge clk) begin
	Q <= D;
end

endmodule
module mux2to1 (
	input [1:0] A,
	input S,
	output reg Y
);

always @(A or S) begin
	case(S)
		0: Y <= A[0];
		1: Y <= A[1];
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

wire [2:0] q;
wire [2:0] r;

flipflop ff1 (.clk(clk), .D(q_in), .Q(q[0]));
flipflop ff2 (.clk(clk), .D(q[1]), .Q(q[1]));
flipflop ff3 (.clk(clk), .D(q[2]), .Q(q[2]));

mux2to1 mux (.A({q[1], q[2]}), .S(L), .Y(r[0]));

assign r[1] = r_in;
assign r[2] = r_in;

always @(posedge clk) begin
	if (L) begin
		Q <= r;
	end else begin
		Q <= {q[1] ^ q[2], q[0], q[2]};
	end
end

endmodule
