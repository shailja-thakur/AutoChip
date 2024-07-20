module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define all the intermediate signals
wire w1, w2;

// Instantiate the logic gates
and gate1 (w1, a, b);
and gate2 (w2, c, d);
or gate3 (out, w1, w2);

endmodule
module and (
	output reg out,
	input a,
	input b
);
always @(a, b)
begin
	out = a & b;
end
endmodule
module or (
	output reg out,
	input a,
	input b
);
always @(a, b)
begin
	out = a | b;
end
endmodule
