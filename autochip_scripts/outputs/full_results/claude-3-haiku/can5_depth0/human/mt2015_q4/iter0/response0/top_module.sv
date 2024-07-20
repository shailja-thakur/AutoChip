module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_b1, z_a2, z_b2;

// Module A implementation
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
    reg z;
    always @(*) begin
        case ({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
        endcase
    end
endmodule
