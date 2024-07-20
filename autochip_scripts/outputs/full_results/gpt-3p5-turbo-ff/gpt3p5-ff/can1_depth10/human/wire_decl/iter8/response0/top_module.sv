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

    and gate1 (
        .out(intermediate1),
        .in1(a),
        .in2(b)
    );

    and gate2 (
        .out(intermediate2),
        .in1(c),
        .in2(d)
    );

    or gate3 (
        .out(out),
        .in1(intermediate1),
        .in2(intermediate2)
    );

    not gate4 (
        .out(out_n),
        .in(out)
    );

endmodule
module and (
    output wire out,
    input wire in1,
    input wire in2
);

    assign out = in1 & in2;
    
endmodule
module or (
    output wire out,
    input wire in1,
    input wire in2
);

    assign out = in1 | in2;

endmodule
module not (
    output wire out,
    input wire in
);

    assign out = ~in;
    
endmodule
