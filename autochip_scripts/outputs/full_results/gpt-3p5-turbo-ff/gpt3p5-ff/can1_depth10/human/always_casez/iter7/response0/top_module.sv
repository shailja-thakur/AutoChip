module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @* begin
		casez (in)
			8'b0000_0001: pos = 1;
			8'b0000_001_: pos = 2;
			8'b0000_01__: pos = 3;
			8'b0000_1___: pos = 4;
			8'b0001_____: pos = 5;
			8'b001______: pos = 6;
			8'b01_______: pos = 7;
			8'b1________: pos = 8;
			default: pos = 0;
		endcase
	end

endmodule
