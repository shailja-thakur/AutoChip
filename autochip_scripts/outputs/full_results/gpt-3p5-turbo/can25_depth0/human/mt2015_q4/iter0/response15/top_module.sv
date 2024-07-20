module A(
    input x,
    input y,
    output z);

    always @(*) begin
        z = (x ^ y) & x;
    end

endmodule
module B(
    input x,
    input y,
    output z);

    always @(*) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 1;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end

endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a_out1, a_out2, b_out1, b_out2;
    wire or_out, and_out, xor_out;

    A a1(.x(x), .y(y), .z(a_out1));
    A a2(.x(x), .y(y), .z(a_out2));
    B b1(.x(x), .y(y), .z(b_out1));
    B b2(.x(x), .y(y), .z(b_out2));

    assign or_out = a_out1 | b_out1;
    assign and_out = a_out2 & b_out2;
    assign xor_out = or_out ^ and_out;

    assign z = xor_out;

endmodule
