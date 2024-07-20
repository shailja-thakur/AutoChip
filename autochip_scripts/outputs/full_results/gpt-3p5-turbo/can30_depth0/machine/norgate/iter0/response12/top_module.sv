module top_module(
	input a, 
	input b,
	output out
);
    
    // OR gate
    wire or_result;
    or_gate OR1(
        .a(a),
        .b(b),
        .out(or_result)
    );
    
    // Inverter
    inverter INV1(
        .in(or_result),
        .out(out)
    );
    
    // OR gate module definition
    module or_gate(
        input a,
        input b,
        output out
    );
        assign out = a | b;
    endmodule
module inverter(
        input in,
        output out
    );
        assign out = ~in;
    endmodule
