module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

wire mux_out;
assign out_assign = mux_out;

always @ (sel_b1 or sel_b2)
begin
	if (sel_b1 && sel_b2)
		out_always = b;
	else
		out_always = a;
end

mux_2to1 mux_inst (
	.in_a(a),
	.in_b(b),
	.sel(sel_b1 & sel_b2),
	.out(mux_out)
);

endmodule
module mux_2to1 (
	input in_a,
	input in_b,
	input sel,
	output reg out
);
 
always @ (sel)
begin
	if (sel)
		out = in_b;
	else
		out = in_a;
end
 
endmodule
