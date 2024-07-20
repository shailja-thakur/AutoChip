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
		3'b000, 1'b0: Y <= 3'b000; // y=0, x=0
		3'b000, 1'b1: Y <= 3'b001; // y=0, x=1
		3'b001, 1'b0: Y <= 3'b001; // y=1, x=0
		3'b001, 1'b1: Y <= 3'b100; // y=1, x=1
		3'b010, 1'b0: Y <= 3'b010; // y=2, x=0
		3'b010, 1'b1: Y <= 3'b001; // y=2, x=1
		3'b011, 1'b0: Y <= 3'b001; // y=3, x=0
		3'b011, 1'b1: Y <= 3'b010; // y=3, x=1
		3'b100, 1'b0: Y <= 3'b011; // y=4, x=0
		3'b100, 1'b1: Y <= 3'b100; // y=4, x=1
		default: Y <= 3'b000;
	endcase
end

assign Y0 = Y[0];
assign z = (Y == 3'b011 || Y == 3'b100);

endmodule
