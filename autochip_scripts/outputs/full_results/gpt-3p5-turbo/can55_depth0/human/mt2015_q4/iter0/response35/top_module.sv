module A(
    input x,
    input y,
    output z);

    assign z = (x^y) & x;

endmodule
module B(
    input x,
    input y,
    output z);
    
    reg z;

    always @(x or y)
        case({x, y})
            2'b00: z = 1'b1;
            2'b11: z = 1'b1;
            default: z = 1'b0;
        endcase

endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a_out_1, a_out_2, b_out_1, b_out_2;
    wire or_out, and_out;

    A a1(x, y, a_out_1);
    A a2(x, y, a_out_2);
    B b1(x, y, b_out_1);
    B b2(x, y, b_out_2);

    assign or_out = a_out_1 | b_out_1;
    assign and_out = a_out_2 & b_out_2;
    assign z = or_out ^ and_out;

endmodule
