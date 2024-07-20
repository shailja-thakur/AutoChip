module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;

    and_gate first_gate(
        .a(x),
        .b(y),
        .z(a)
    );

    and_gate second_gate(
        .a(y),
        .b(x),
        .z(b)
    );

    and_gate third_gate(
        .a(a),
        .b(b),
        .z(z)
    );
    
endmodule
