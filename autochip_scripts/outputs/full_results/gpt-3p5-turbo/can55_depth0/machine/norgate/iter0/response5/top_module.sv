module top_module(
    input a,
    input b,
    output out
);
    wire or_output;
    
    or_gate or_inst(
        .a(a),
        .b(b),
        .out(or_output)
    );
    
    not_gate not_inst(
        .in(or_output),
        .out(out)
    );
    
    // OR gate module
    module or_gate(
        input a,
        input b,
        output out
    );
        assign out = a | b;
    endmodule
module not_gate(
        input in,
        output out
    );
        assign out = ~in;
    endmodule
