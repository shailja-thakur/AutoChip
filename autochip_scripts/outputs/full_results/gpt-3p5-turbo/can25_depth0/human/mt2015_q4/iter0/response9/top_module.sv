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

    always @(x or y)
        case({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase

endmodule
module top_module(
    input x,
    input y,
    output z);

    A A1(.x(x), .y(y), .z(z1));
    A A2(.x(x), .y(y), .z(z2));
    B B1(.x(x), .y(y), .z(z3));
    B B2(.x(x), .y(y), .z(z4));

    wire or_out;
    wire and_out;
    
    assign or_out = z1 | z3;
    assign and_out = z2 & z4;
    assign z = or_out ^ and_out;

endmodule
