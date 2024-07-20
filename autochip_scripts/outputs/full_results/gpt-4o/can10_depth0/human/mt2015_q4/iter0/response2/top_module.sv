module top_module(
    input x,
    input y,
    output z);

    wire A1_out, A2_out, B1_out, B2_out;
    wire OR_out, AND_out;

    // Instantiate submodules A and B
    A submodule_A1 (
        .x(x),
        .y(y),
        .z(A1_out)
    );

    A submodule_A2 (
        .x(x),
        .y(y),
        .z(A2_out)
    );

    B submodule_B1 (
        .x(x),
        .y(y),
        .z(B1_out)
    );

    B submodule_B2 (
        .x(x),
        .y(y),
        .z(B2_out)
    );

    // OR gate for the first pair of A and B
    assign OR_out = A1_out | B1_out;

    // AND gate for the second pair of A and B
    assign AND_out = A2_out & B2_out;

    // XOR gate to generate output z
    assign z = OR_out ^ AND_out;

endmodule
module A(
    input x,
    input y,
    output z);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output reg z);

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
