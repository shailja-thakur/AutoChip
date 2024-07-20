module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @* begin
		casez (in)
			8'b0000_0001: pos = 0;
			8'b0000_0010: pos = 1;
			8'b0000_01__: pos = 2;
			8'b0000_1___: pos = 3;
			8'b0001_____: pos = 4;
			8'b001______: pos = 5;
			8'b01_______: pos = 6;
			8'b1________: pos = 7;
			default: pos = 8;
		endcase
	end

endmodule
