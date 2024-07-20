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
        if (y == 1 && x == 1)
            z = 1;
        else if (y == 1 && x == 0)
            z = 0;
        else if (y == 0 && x == 1)
            z = 0;
        else 
            z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire za1, za2, zb1, zb2;
    wire or_out, and_out;

    A A1 (
        .x(x),
        .y(y),
        .z(za1)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(za2)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(zb1)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(zb2)
    );

    assign or_out = za1 | zb1;
    assign and_out = za2 & zb2;
    assign z = or_out ^ and_out;
endmodule
