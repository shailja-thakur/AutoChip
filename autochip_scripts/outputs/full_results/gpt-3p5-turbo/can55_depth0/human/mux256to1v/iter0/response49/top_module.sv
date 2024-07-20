module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	reg [3:0] temp;

	always @(*) begin
		case (sel)
			8'b00000000 : temp = in[3:0];
			8'b00000001 : temp = in[7:4];
			8'b00000010 : temp = in[11:8];
			// Add additional cases for sel=3, sel=4, sel=5, sel=6, sel=7
			// Example: 8'b00000100 : temp = in[43:40];
			default : temp = 4'b0;
		endcase
	end

	assign out = temp;

endmodule
