module A(
    input x,
    input y,
    output z);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z);

    reg z;
    initial
    begin
        #0 z = 1;
        #25 z = 0;
        #35 z = x & ~y;
        #60 z = x & ~y;
        #65 z = y & ~x;
        #75 z = x & y;
        #80 z = x & y;
        #85 z = x & y;
        #90 z = 0;
    end

endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a_out_1, b_out_1, a_out_2, b_out_2;
    A a1 (.x(x), .y(y), .z(a_out_1));
    B b1 (.x(x), .y(y), .z(b_out_1));
    A a2 (.x(x), .y(y), .z(a_out_2));
    B b2 (.x(x), .y(y), .z(b_out_2));
    wire or_out, and_out;
    assign or_out = a_out_1 | b_out_1;
    assign and_out = a_out_2 & b_out_2;
    assign z = or_out ^ and_out;

endmodule
