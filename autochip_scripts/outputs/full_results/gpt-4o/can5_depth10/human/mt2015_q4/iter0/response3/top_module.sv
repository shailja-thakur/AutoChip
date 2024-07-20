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
    output z
);
    assign z = (y == 0) ? 1 :
               (x == 0 && y == 1) ? 0 :
               (x == 1 && y == 1) ? 1 : 1; // Additional case added to maintain the waveform behavior
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_result, and_result;

    // Instantiate two A submodules
    A A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );
    A A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    // Instantiate two B submodules
    B B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );
    B B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // Connect the outputs of the first A and B submodules to an OR gate
    assign or_result = zA1 | zB1;

    // Connect the outputs of the second A and B submodules to an AND gate
    assign and_result = zA2 & zB2;

    // Connect the outputs of the OR and AND gates to an XOR gate
    assign z = or_result ^ and_result;

endmodule
