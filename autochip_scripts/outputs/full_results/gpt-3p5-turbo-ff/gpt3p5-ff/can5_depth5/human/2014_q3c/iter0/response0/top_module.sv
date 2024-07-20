module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;

	always @(posedge clk) begin
		case ({x,y})
			2'b00 | 2'b01 | 2'b10: Y <= 3'b000;
			2'b11: Y <= 3'b001;
			3'b100: Y <= 3'b011;
		endcase

		Y0 <= Y[0];
		z <= (Y == 3'b011) || (Y == 3'b100);
	end

endmodule
