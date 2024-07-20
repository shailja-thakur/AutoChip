module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] sel_internal;

assign sel_internal = sel;

assign out = (sel_internal[7]) ? in[255] :
	     (sel_internal[6]) ? in[254] :
	     (sel_internal[5]) ? in[253] :
	     (sel_internal[4]) ? in[252] :
	     (sel_internal[3]) ? in[251] :
	     (sel_internal[2]) ? in[250] :
	     (sel_internal[1]) ? in[249] :
	                    in[248];

endmodule
