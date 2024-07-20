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

    always @(*)
    begin
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else if (x == 1 && y == 1)
            z = 1;
    end

endmodule
module top_module(
    input x,
    input y,
    output z
    );

    wire a_out1, b_out1, a_out2, b_out2;

    A a1(x, y, a_out1);
    B b1(x, y, b_out1);

    A a2(x, y, a_out2);
    B b2(x, y, b_out2);

    assign z = a_out1 | b_out1 ^ a_out2 & b_out2;

endmodule
