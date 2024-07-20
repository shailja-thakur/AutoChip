module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
    assign out = (!c && !d) || (!c && !b) || (!c && a) || (c && b && !a && !d) || (c && b && a); 
endmodule
