module A (
    input wire x,
    input wire y,
    output wire z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input wire x,
    input wire y,
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
    input wire x,
    input wire y,
    output wire z
);
    wire a1_z, a2_z, b1_z, b2_z;
    wire or_z, and_z;

    // Instantiate A submodules
    A a1 (.x(x), .y(y), .z(a1_z));
    A a2 (.x(x), .y(y), .z(a2_z));

    // Instantiate B submodules
    B b1 (.x(x), .y(y), .z(b1_z));
    B b2 (.x(x), .y(y), .z(b2_z));

    // OR gate for the first pair (A and B)
    assign or_z = a1_z | b1_z;

    // AND gate for the second pair (A and B)
    assign and_z = a2_z & b2_z;

    // XOR gate for the final output
    assign z = or_z ^ and_z;
endmodule
