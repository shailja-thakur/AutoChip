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
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
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
    wire z1_a, z1_b, z2_a, z2_b;
    wire or_out, and_out;

    A a1 (.x(x), .y(y), .z(z1_a));
    B b1 (.x(x), .y(y), .z(z1_b));
    A a2 (.x(x), .y(y), .z(z2_a));
    B b2 (.x(x), .y(y), .z(z2_b));

    assign or_out = z1_a | z1_b;
    assign and_out = z2_a & z2_b;

    assign z = or_out ^ and_out;
endmodule
