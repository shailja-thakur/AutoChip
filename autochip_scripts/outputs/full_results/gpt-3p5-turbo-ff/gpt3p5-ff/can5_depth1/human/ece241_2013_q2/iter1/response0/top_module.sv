module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

assign out_sop = (a==2) | (a==7) | (a==15);
assign out_pos = (a==0) | (a==1) | (a==4) | (a==5) | (a==6) | (a==9) | (a==10) | (a==13) | (a==14);
endmodule
