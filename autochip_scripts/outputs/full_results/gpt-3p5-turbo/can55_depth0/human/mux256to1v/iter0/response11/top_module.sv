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
		3: temp = in[15:12];
		4: temp = in[19:16];
		5: temp = in[23:20];
		6: temp = in[27:24];
		7: temp = in[31:28];
		default: temp = 4'b0;
	endcase
end

assign out = temp;

endmodule
