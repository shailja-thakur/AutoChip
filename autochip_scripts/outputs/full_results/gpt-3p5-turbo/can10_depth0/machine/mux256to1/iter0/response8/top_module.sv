module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	reg [7:0] idx;
	assign out = in[idx];
	
	always @ (sel)
		begin
			case (sel)
				8'b00000000: idx = 0;
				8'b00000001: idx = 1;
				8'b00000010: idx = 2;
				8'b00000011: idx = 3;
				8'b00000100: idx = 4;
				8'b00000101: idx = 5;
				8'b00000110: idx = 6;
				8'b00000111: idx = 7;
				default: idx = 0;
			endcase
		end
endmodule
