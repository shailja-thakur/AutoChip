module module_A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module module_B(
    input x,
    input y,
    output reg z
);
    always @(*)
    begin
        if (({x, y} == 2'b00) || ({x, y} == 2'b11))
            z = 1;
        else
            z = 0;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_out, b1_out, a2_out, b2_out;
    wire or_out, and_out;

    // Instantiate Submodules
    module_A u1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    module_B u2 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    module_A u3 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    module_B u4 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate for first pair of A and B submodules
    assign or_out = a1_out | b1_out;

    // AND gate for second pair of A and B submodules
    assign and_out = a2_out & b2_out;

    // XOR gate for final output
    assign z = or_out ^ and_out;
endmodule
