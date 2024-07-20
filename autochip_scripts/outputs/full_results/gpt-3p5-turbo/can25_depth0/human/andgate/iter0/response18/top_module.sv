module top_module(
	input a, 
	input b,
	output out
);
    and_gate and(
        .a(a),
        .b(b),
        .out(out)
    );
endmodule
