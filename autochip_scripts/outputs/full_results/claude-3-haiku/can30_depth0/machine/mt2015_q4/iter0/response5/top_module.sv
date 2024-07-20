module top_module(
    input x,
    input y,
    output z
);

    wire a_out, b_out;

    gate1 gate1_inst (
        .a(x),
        .b(y),
        .out(a_out)
    );

    gate2 gate2_inst (
        .a(y),
        .b(x),
        .out(b_out)
    );

    gate3 gate3_inst (
        .a(a_out),
        .b(b_out),
        .out(z)
    );

endmodule
module gate1 (
    input a,
    input b,
    output out
);
    assign out = a & b;
endmodule
module gate2 (
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
module gate3 (
    input a,
    input b,
    output out
);
    assign out = a ^ b;
endmodule
