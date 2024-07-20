module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	assign out = sel[7] ? in[255] : sel[6] ? in[254] : sel[5] ? in[253] :
		    sel[4] ? in[252] : sel[3] ? in[251] : sel[2] ? in[250] :
		    sel[1] ? in[249] : in[248];
endmodule
