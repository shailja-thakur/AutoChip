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
        if ((x == 0 && y == 0) || (x == 1 && y == 1)) begin
            z = 1;
        end else begin
            z = 0;
        end
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire zA1, zA2, zB1, zB2;
    wire or_output, and_output;

    // Instantiating and connecting modules
    A A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate connecting A1 and B1
    assign or_output = zA1 | zB1;

    // AND gate connecting A2 and B2
    assign and_output = zA2 & zB2;

    // XOR gate connecting OR and AND outputs
    assign z = or_output ^ and_output;

endmodule
