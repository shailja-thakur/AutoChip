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
        case ({x,y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2;
    wire z_B1, z_B2;
    wire or_out, and_out;

    A u_A1 (.x(x), .y(y), .z(z_A1));
    A u_A2 (.x(x), .y(y), .z(z_A2));
    B u_B1 (.x(x), .y(y), .z(z_B1));
    B u_B2 (.x(x), .y(y), .z(z_B2));

    assign or_out = z_A1 | z_B1;
    assign and_out = z_A2 & z_B2;
    assign z = or_out ^ and_out;
endmodule
