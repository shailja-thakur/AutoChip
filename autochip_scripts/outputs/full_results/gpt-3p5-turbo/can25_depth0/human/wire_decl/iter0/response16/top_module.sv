module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire and1_out;
    wire and2_out;
    
    and gate1 (
        .a(a),
        .b(b),
        .z(and1_out)
    );
    
    and gate2 (
        .a(c),
        .b(d),
        .z(and2_out)
    );
    
    or gate3 (
        .a(and1_out),
        .b(and2_out),
        .z(out)
    );
    
    not gate4 (
        .a(out),
        .z(out_n)
    );

endmodule
module and (
    input a,
    input b,
    output z);
    
    assign z = a & b;
    
endmodule
module or (
    input a,
    input b,
    output z);
    
    assign z = a | b;
    
endmodule
module not (
    input a,
    output z);
    
    assign z = ~a;
    
endmodule
