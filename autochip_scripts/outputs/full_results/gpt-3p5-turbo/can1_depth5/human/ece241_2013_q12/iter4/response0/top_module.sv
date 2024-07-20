module shift_register (
	input clk,
	input enable,
	input S,
	output [7:0] Q
);

reg [7:0] Q_reg;
reg [6:0] Q_shift;

always @(posedge clk) begin
	if (enable)
		Q_reg <= {S, Q_reg[7:1]};
	Q_shift <= Q_reg[6:0];
end

assign Q = {Q_shift, Q_reg[7]};

endmodule
module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

wire [7:0] Q;

shift_register sr(
	.clk(clk),
	.enable(enable),
	.S(S),
	.Q(Q)
);

always @(*) begin
	case({A, B, C})
		3'b000: Z = Q[0];
		3'b001: Z = Q[1];
		3'b010: Z = Q[2];
		3'b011: Z = Q[3];
		3'b100: Z = Q[4];
		3'b101: Z = Q[5];
		3'b110: Z = Q[6];
		3'b111: Z = Q[7];
	endcase
end

endmodule
