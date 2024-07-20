module top_module(
    input x,
    input y,
    output z
);

    wire a1_out, a2_out, b1_out, b2_out;

    module_A a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    module_A a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    module_B b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    module_B b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    or (temp1, a1_out, b1_out);
    and (temp2, a2_out, b2_out);
    xor (z, temp1, temp2);

endmodule
module module_A(
    input x,
    input y,
    output z
);

    assign z = (x ^ y) & x;

endmodule
module module_B(
    input x,
    input y,
    output z
);

    reg z;

    always @(*) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end

endmodule
