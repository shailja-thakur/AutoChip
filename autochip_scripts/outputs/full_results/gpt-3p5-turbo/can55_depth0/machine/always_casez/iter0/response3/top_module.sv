module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(in) begin
		casez(in) 
			// List of cases and corresponding output values
			8'b001xxxxx: pos = 3'b0;
			8'b01xxxxxx: pos = 3'b1;
			8'b1xxxxxxx: pos = 3'b2;
			default: pos = 3'b0;
		endcase
	end

endmodule
