module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output reg z
);
    always @(*) begin
        if (x == 0 && y == 0) z = 1;
        else if (x == 1 && y == 0) z = 0;
        else if (x == 0 && y == 1) z = 0;
        else if (x == 1 && y == 1) z = 1;
        else z = 1; // Default case, should not occur
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire A1_out, A2_out, B1_out, B2_out;
    wire or_out, and_out;

    // Instantiation of first A submodule
    A U1 (
        .x(x),
        .y(y),
        .z(A1_out)
    );

    // Instantiation of first B submodule
    B U2 (
        .x(x),
        .y(y),
        .z(B1_out)
    );

    // Instantiation of second A submodule
    A U3 (
        .x(x),
        .y(y),
        .z(A2_out)
    );

    // Instantiation of second B submodule
    B U4 (
        .x(x),
        .y(y),
        .z(B2_out)
    );

    // OR gate
    assign or_out = A1_out | B1_out;

    // AND gate
    assign and_out = A2_out & B2_out;

    // XOR gate
    assign z = or_out ^ and_out;
endmodule
