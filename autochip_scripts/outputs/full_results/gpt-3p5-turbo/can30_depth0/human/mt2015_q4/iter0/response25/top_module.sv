module A(input x, input y, output z);
    assign z = (x ^ y) & x;
endmodule
module B(input x, input y, output z);
    assign z = (x | y) & (~x ^ y);
endmodule
module top_module(input x, input y, output z);
    wire a1, a2, b1, b2;
    A a_module1(.x(x), .y(y), .z(a1));
    B b_module1(.x(x), .y(y), .z(b1));
    A a_module2(.x(x), .y(y), .z(a2));
    B b_module2(.x(x), .y(y), .z(b2));
    wire or_out, and_out;
    or or_gate(.a(a1), .b(b1), .z(or_out));
    and and_gate(.a(a2), .b(b2), .z(and_out));
    xor xor_gate(.a(or_out), .b(and_out), .z(z));
endmodule
