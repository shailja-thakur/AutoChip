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
    always @(x, y) begin
        if ((x == 0 && y == 0) || (x == 1 && y == 1))
            z <= 1;
        else
            z <= 0;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_out, and_out;

    A A1 (.x(x), .y(y), .z(zA1));
    A A2 (.x(x), .y(y), .z(zA2));
    B B1 (.x(x), .y(y), .z(zB1));
    B B2 (.x(x), .y(y), .z(zB2));

    assign or_out = zA1 | zB1;
    assign and_out = zA2 & zB2;
    assign z = or_out ^ and_out;
endmodule
