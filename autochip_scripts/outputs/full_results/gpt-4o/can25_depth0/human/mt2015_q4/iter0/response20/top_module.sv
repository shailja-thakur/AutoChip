module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input clk,
    input x,
    input y,
    output reg z
);
    always @(posedge clk) begin
        case ({x, y})
            2'b00: z <= 1;
            2'b01: z <= 0;
            2'b10: z <= 0;
            2'b11: z <= 1;
            default: z <= 1;
        endcase
    end
endmodule
module top_module(
	input clk,
	input x,
	input y,
	output z
);

    wire z_a1, z_b1, z_a2, z_b2;
    wire or_out, and_out;

    // Instantiating the first pair of A and B submodules
    A u1 (
        .x(x),
        .y(y),
        .z(z_a1)
    );

    B u2 (
        .clk(clk),
        .x(x),
        .y(y),
        .z(z_b1)
    );

    // Instantiating the second pair of A and B submodules
    A u3 (
        .x(x),
        .y(y),
        .z(z_a2)
    );

    B u4 (
        .clk(clk),
        .x(x),
        .y(y),
        .z(z_b2)
    );

    // Connecting OR gate to the output of the first pair
    assign or_out = z_a1 | z_b1;

    // Connecting AND gate to the output of the second pair
    assign and_out = z_a2 & z_b2;

    // Connecting XOR gate to the output of OR and AND gates
    assign z = or_out ^ and_out;

endmodule
