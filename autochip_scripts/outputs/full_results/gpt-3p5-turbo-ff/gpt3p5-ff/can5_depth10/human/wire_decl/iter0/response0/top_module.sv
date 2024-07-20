module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );
    
    wire intermediate_wire_1;
    wire intermediate_wire_2;
    
    and_gate and1 (
        .a(a),
        .b(b),
        .out(intermediate_wire_1)
    );
    
    and_gate and2 (
        .a(c),
        .b(d),
        .out(intermediate_wire_2)
    );
    
    or_gate or1 (
        .a(intermediate_wire_1),
        .b(intermediate_wire_2),
        .out(out)
    );
    
    not_gate not1 (
        .a(out),
        .out(out_n)
    );
    
endmodule
