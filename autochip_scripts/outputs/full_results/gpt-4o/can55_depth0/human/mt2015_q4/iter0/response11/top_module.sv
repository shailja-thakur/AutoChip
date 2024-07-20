module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input wire x,
    input wire y,
    output reg z
);
    always @* begin
        case ({x,y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1'bx;
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;

    A u1 (.x(x), .y(y), .z(a1_out));
    B u2 (.x(x), .y(y), .z(b1_out));
    A u3 (.x(x), .y(y), .z(a2_out));
    B u4 (.x(x), .y(y), .z(b2_out));

    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
endmodule
