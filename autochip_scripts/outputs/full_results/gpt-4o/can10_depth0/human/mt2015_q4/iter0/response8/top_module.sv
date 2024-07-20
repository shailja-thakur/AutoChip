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
    reg z_reg;
    always @(*) begin
        case ({x, y})
            2'b00: z_reg = 1;
            2'b01: z_reg = 0;
            2'b10: z_reg = 0;
            2'b11: z_reg = 1;
            default: z_reg = 1;
        endcase
    end
    assign z = z_reg;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_out, a2_out, b1_out, b2_out;

    // Instantiate A and B modules
    A a1 (.x(x), .y(y), .z(a1_out));
    B b1 (.x(x), .y(y), .z(b1_out));
    A a2 (.x(x), .y(y), .z(a2_out));
    B b2 (.x(x), .y(y), .z(b2_out));

    // Intermediate signals for OR and AND gates
    wire or_out, and_out;

    assign or_out  = a1_out | b1_out;
    assign and_out = a2_out & b2_out;

    // Output of top module
    assign z = or_out ^ and_out;
endmodule
