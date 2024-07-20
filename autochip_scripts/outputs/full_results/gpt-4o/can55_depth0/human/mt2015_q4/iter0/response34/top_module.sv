module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output z
);
    reg z;
    always @(*) begin
        if(x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else  //(x == 1 && y == 1)
            z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;

    // Instantiate the first pair of A and B submodules
    A u_a1(
        .x(x),
        .y(y),
        .z(a1_out)
    );

    B u_b1(
        .x(x),
        .y(y),
        .z(b1_out)
    );

    // Instantiate the second pair of A and B submodules
    A u_a2(
        .x(x),
        .y(y),
        .z(a2_out)
    );

    B u_b2(
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate for the first pair of A and B submodules
    assign or_out = a1_out | b1_out;

    // AND gate for the second pair of A and B submodules
    assign and_out = a2_out & b2_out;

    // XOR gate for the outputs of the OR and AND gates
    assign z = or_out ^ and_out;
endmodule
