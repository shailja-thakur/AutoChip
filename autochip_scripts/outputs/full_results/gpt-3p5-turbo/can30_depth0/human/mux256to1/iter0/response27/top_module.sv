module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

wire [0:255] sel_wire;

assign sel_wire[0] = sel == 0;
assign sel_wire[1] = sel == 1;
assign sel_wire[2] = sel == 2;
// ... Continue assigning sel_wire for all 256 possible values

assign out = in & sel_wire; // bitwise AND operation between in and sel_wire

endmodule
