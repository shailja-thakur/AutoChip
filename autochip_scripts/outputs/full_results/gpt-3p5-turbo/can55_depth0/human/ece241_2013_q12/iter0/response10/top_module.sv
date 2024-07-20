module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

// Creating an 8-bit shift register with 8 D-type flip-flops
reg [7:0] Q;
wire Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7;

DFF #(1) ff0 (
	.clk(clk),
	.D(S),
	.Q(Q0)
);

DFF #(1) ff1 (
	.clk(clk),
	.D(Q0),
	.Q(Q1)
);

DFF #(1) ff2 (
	.clk(clk),
	.D(Q1),
	.Q(Q2)
);

DFF #(1) ff3 (
	.clk(clk),
	.D(Q2),
	.Q(Q3)
);

DFF #(1) ff4 (
	.clk(clk),
	.D(Q3),
	.Q(Q4)
);

DFF #(1) ff5 (
	.clk(clk),
	.D(Q4),
	.Q(Q5)
);

DFF #(1) ff6 (
	.clk(clk),
	.D(Q5),
	.Q(Q6)
);

DFF #(1) ff7 (
	.clk(clk),
	.D(Q6),
	.Q(Q7)
);

// Mux to select the output based on A, B, and C inputs
always @(posedge clk) begin
	if (enable) begin
		case({A, B, C})
			3'b000: Z <= Q0;
			3'b001: Z <= Q1;
			3'b010: Z <= Q2;
			3'b011: Z <= Q3;
			3'b100: Z <= Q4;
			3'b101: Z <= Q5;
			3'b110: Z <= Q6;
			3'b111: Z <= Q7;
		endcase
	end
end

endmodule
