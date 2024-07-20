module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out,
    output wire out_n
);

    wire intermediate1;
    wire intermediate2;

    and_gate gate1 (
        .out(intermediate1),
        .in1(a),
        .in2(b)
    );

    and_gate gate2 (
        .out(intermediate2),
        .in1(c),
        .in2(d)
    );

    or_gate gate3 (
        .out(out),
        .in1(intermediate1),
        .in2(intermediate2)
    );

    not_gate gate4 (
        .out(out_n),
        .in(out)
    );

endmodule
module and_gate (
    output wire out,
    input wire in1,
    input wire in2
);

    assign out = in1 & in2;
    
endmodule
module or_gate (
    output wire out,
    input wire in1,
    input wire in2
);

    assign out = in1 | in2;

endmodule
module not_gate (
    output wire out,
    input wire in
);

    assign out = ~in;
    
endmodule
