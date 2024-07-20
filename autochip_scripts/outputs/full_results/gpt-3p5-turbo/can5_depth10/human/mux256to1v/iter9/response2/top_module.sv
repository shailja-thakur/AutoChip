module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	assign out = sel[7:4] == 0 ? in[3:0] :
	             sel[7:4] == 1 ? in[7:4] :
	             sel[7:4] == 2 ? in[11:8] :
	             sel[7:4] == 3 ? in[15:12] :
	             sel[7:4] == 4 ? in[19:16] :
	             sel[7:4] == 5 ? in[23:20] :
	             sel[7:4] == 6 ? in[27:24] :
	             sel[7:4] == 7 ? in[31:28] :
	             4'b0;

endmodule
