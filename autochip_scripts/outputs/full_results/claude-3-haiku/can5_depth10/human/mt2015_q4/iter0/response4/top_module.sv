module top_module(
    input x,
    input y,
    output z
);

    wire a1, a2, b1, b2;

    // Module A implementation
    module_A sub_a1 (
        .x(x),
        .y(y),
        .z(a1)
    );

    module_A sub_a2 (
        .x(x),
        .y(y),
        .z(a2)
    );

    // Module B implementation
    module_B sub_b1 (
        .x(x),
        .y(y),
        .z(b1)
    );

    module_B sub_b2 (
        .x(x),
        .y(y),
        .z(b2)
    );

    // Interconnections
    wire or_out, and_out;
    assign or_out = a1 | b1;
    assign and_out = a2 & b2;

    // Final output
    assign z = or_out ^ and_out;

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
