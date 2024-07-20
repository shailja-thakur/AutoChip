module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;

	always @(posedge clk) begin
		case({y, x})
			3'b000, x=0 : Y <= 3'b000;
			3'b000, x=1 : Y <= 3'b001;
			3'b001, x=0 : Y <= 3'b001;
			3'b001, x=1 : Y <= 3'b100;
			3'b010, x=0 : Y <= 3'b010;
			3'b010, x=1 : Y <= 3'b001;
			3'b011, x=0 : Y <= 3'b001;
			3'b011, x=1 : Y <= 3'b010;
			3'b100, x=0 : Y <= 3'b011;
			3'b100, x=1 : Y <= 3'b100;
			default : Y <= 3'b000;
		endcase
	end

	assign {Y0, z} = {(Y == 3'b111) ? 1'b1 : 1'b0, (Y == 3'b011) ? 1'b1 : 1'b0};

endmodule
