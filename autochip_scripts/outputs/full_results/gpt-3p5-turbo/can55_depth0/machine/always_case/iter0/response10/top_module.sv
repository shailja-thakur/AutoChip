module top_module (
	input [2:0] sel,
	input [3:0] data0,
	input [3:0] data1,
	input [3:0] data2,
	input [3:0] data3,
	input [3:0] data4,
	input [3:0] data5,
	output reg [3:0] out
);
	always @(sel, data0, data1, data2, data3, data4, data5)
	begin
		case(sel)
			3'b000: out <= data0; // if sel is 0, assign data0 to out
			3'b001: out <= data1; // if sel is 1, assign data1 to out
			3'b010: out <= data2; // if sel is 2, assign data2 to out
			3'b011: out <= data3; // if sel is 3, assign data3 to out
			3'b100: out <= data4; // if sel is 4, assign data4 to out
			3'b101: out <= data5; // if sel is 5, assign data5 to out
			default: out <= 4'b0000; // if sel is any other value, assign 0 to out
		endcase
	end
endmodule
