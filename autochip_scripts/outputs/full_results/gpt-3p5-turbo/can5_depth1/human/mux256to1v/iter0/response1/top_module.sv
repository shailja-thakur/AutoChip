module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [3:0] temp;

always @(*) begin
	case(sel)
		0: temp = in[3:0];
		1: temp = in[7:4];
		2: temp = in[11:8];
		// add more cases for the remaining selections
	endcase
end

assign out = temp;

endmodule
