module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output reg z
);
    always @(*) begin
        if (x == 0 && y == 0) z = 1;
        else if (x == 1 && y == 0) z = 0;
        else if (x == 0 && y == 1) z = 0;
        else if (x == 1 && y == 1) z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z1_A, z1_B, z2_A, z2_B;
    wire or_result, and_result;

    // Instantiate first A and B modules
    A A1 (
        .x(x),
        .y(y),
        .z(z1_A)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(z1_B)
    );

    // OR gate for the first pair of A and B modules
    assign or_result = z1_A | z1_B;

    // Instantiate second A and B modules
    A A2 (
        .x(x),
        .y(y),
        .z(z2_A)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z2_B)
    );

    // AND gate for the second pair of A and B modules
    assign and_result = z2_A & z2_B;

    // XOR gate between the results of the OR and AND gates
    assign z = or_result ^ and_result;
endmodule
