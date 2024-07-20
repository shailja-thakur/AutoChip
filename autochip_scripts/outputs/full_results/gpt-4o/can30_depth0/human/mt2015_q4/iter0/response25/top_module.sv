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
    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;
    
    A a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );
    B b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );
    A a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );
    B b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );
    
    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
endmodule
