module top_module (
	input [31:0] in,
	output [31:0] out
);
	reg [7:0] out_0;
	reg [7:0] out_1;
	reg [7:0] out_2;
	reg [7:0] out_3;
	
	always @(*) begin
		out_0 = in[7:0];
		out_1 = in[15:8];
		out_2 = in[23:16];
		out_3 = in[31:24];
		out = {out_3, out_2, out_1, out_0};
	end
	
endmodule
