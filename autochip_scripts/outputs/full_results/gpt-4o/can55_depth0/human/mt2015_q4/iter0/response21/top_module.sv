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
    always @(*)
    begin
        if (!x && !y) z = 1;
        else if (x && !y) z = 0;
        else if (!x && y) z = 0;
        else if (x && y) z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire zA1, zA2, zB1, zB2;
    wire OR_out, AND_out;

    // Instantiating submodule A (first instance)
    A A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    // Instantiating submodule A (second instance)
    A A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    // Instantiating submodule B (first instance)
    B B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    // Instantiating submodule B (second instance)
    B B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // Connecting outputs of first A and B to an OR gate
    assign OR_out = zA1 | zB1;

    // Connecting outputs of second A and B to an AND gate
    assign AND_out = zA2 & zB2;

    // Connecting outputs of OR and AND gates to an XOR gate to get the final output 'z'
    assign z = OR_out ^ AND_out;

endmodule
