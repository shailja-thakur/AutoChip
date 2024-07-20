module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_b1, z_a2, z_b2;

// Instantiate the A and B submodules
module_A a1 (.x(x), .y(y), .z(z_a1));
module_A a2 (.x(x), .y(y), .z(z_a2));
module_B b1 (.x(x), .y(y), .z(z_b1));
module_B b2 (.x(x), .y(y), .z(z_b2));

// Connect the submodules to the logic gates
wire or_out;
assign or_out = z_a1 | z_b1;

wire and_out;
assign and_out = z_a2 & z_b2;

// Connect the logic gates to the top-level output
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
        2'b00: z = 1'b1;
        2'b01: z = 1'b0;
        2'b10: z = 1'b0;
        2'b11: z = 1'b1;
    endcase
end

endmodule
