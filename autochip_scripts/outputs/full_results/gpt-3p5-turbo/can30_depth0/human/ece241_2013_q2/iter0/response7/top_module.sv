module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

wire condition1, condition2;
assign condition1 = (a==1'b0 && b==1'b1 && c==1'b0 && d==1'b0) || (a==1'b0 && b==1'b0 && c==1'b0 && d==1'b0) || (a==1'b1 && b==1'b1 && c==1'b1 && d==1'b1);
assign condition2 = (a==1'b0 && b==1'b0 && c==1'b1 && d==1'b1);

assign out_sop = condition1 || condition2;
assign out_pos = condition1 && condition2;

endmodule
