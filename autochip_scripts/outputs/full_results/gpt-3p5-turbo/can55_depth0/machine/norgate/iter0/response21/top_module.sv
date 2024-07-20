module top_module(
	input a, 
	input b,
	output out
);
    wire or_output;
    
    // OR gate
    or_gate or1(
        .a(a),
        .b(b),
        .out(or_output)
    );
    
    // Inverter
    inv_gate inv1(
        .in(or_output),
        .out(out)
    );
    
endmodule
