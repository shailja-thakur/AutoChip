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
        case ({x, y})
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
    wire z_a1, z_b1; // Output wires for the first pair of A and B
    wire z_a2, z_b2; // Output wires for the second pair of A and B
    wire or_out, and_out;

    // Instantiate the first pair of A and B
    A u1_a (
        .x(x),
        .y(y),
        .z(z_a1)
    );
    
    B u1_b (
        .x(x),
        .y(y),
        .z(z_b1)
    );

    // Instantiate the second pair of A and B
    A u2_a (
        .x(x),
        .y(y),
        .z(z_a2)
    );
    
    B u2_b (
        .x(x),
        .y(y),
        .z(z_b2)
    );

    // OR gate for the first pair
    assign or_out = z_a1 | z_b1;

    // AND gate for the second pair
    assign and_out = z_a2 & z_b2;

    // XOR gate for final output
    assign z = or_out ^ and_out;
endmodule
