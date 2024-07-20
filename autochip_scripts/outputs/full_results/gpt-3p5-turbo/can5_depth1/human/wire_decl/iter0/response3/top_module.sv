module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    wire and1_out;
    wire and2_out;
    
    and gate1 (and1_out, a, b);
    and gate2 (and2_out, c, d);
    or gate3 (out, and1_out, and2_out);
    not gate4 (out_n, out);

endmodule
module and (
    output out,
    input a,
    input b
);
    assign out = a & b;
endmodule
module or (
    output out,
    input a,
    input b
);
    assign out = a | b;
endmodule
module not (
    output out,
    input a
);
    assign out = ~a;
endmodule
