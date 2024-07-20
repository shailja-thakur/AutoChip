module top_module (
	input [3:0] in,
	output reg [1:0] pos
);
	always@(in) begin
		case(in)
		0: pos = 2'b00;
		1: pos = 2'b00;
		2: pos = 2'b01;
		3: pos = 2'b00;
		4: pos = 2'b10;
		5: pos = 2'b00;
		6: pos = 2'b01;
		7: pos = 2'b00;
		8: pos = 2'b11;
		9: pos = 2'b00;
		10: pos = 2'b01;
		11: pos = 2'b00;
		12: pos = 2'b10;
		13: pos = 2'b00;
		14: pos = 2'b01;
		15: pos = 2'b00;
		default: pos = 2'b00;
		endcase
	end
	
endmodule
