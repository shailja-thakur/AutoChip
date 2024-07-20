module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg [1:0] SEL;
	reg [1:0] D;

	always @(posedge clk) begin
		SEL[0] <= L;
		SEL[1] <= E;

		D[0] <= R;
		D[1] <= w;

		case (SEL)
			2'b00: Q <= D[0];
			2'b01: Q <= Q;
			2'b10: Q <= D[1];
			2'b11: Q <= Q;
		endcase
	end
endmodule
