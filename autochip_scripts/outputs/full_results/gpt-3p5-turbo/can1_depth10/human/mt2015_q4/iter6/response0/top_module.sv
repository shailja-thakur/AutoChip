module A(
    input x,
    input y,
    output z);

    assign z = (x^y) & x;

endmodule
module B(
    input x,
    input y,
    output z);

    reg z;

    always @(x, y)
    begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end

endmodule
module top_module(
    input x,
    input y,
    output z);

    A a1 (.x(x), .y(y), .z(z_a1));
    A a2 (.x(x), .y(y), .z(z_a2));
    B b1 (.x(x), .y(y), .z(z_b1));
    B b2 (.x(x), .y(y), .z(z_b2));

    wire z_a1, z_a2, z_b1, z_b2, or_output, and_output;

    // OR gate
    assign #(0) or_output = z_a1 | z_b1;

    // AND gate
    assign #(0) and_output = z_a2 & z_b2;

    // XOR gate
    assign #(0) z = or_output ^ and_output;

endmodule
module top(
    input x,
    input y,
    output z);

    wire z_a1, z_a2, z_b1, z_b2, or_output, and_output;

    // Instantiate A and B modules
    A a1 (.x(x), .y(y), .z(z_a1));
    A a2 (.x(x), .y(y), .z(z_a2));
    B b1 (.x(x), .y(y), .z(z_b1));
    B b2 (.x(x), .y(y), .z(z_b2));

    // OR gate
    assign or_output = z_a1 | z_b1;

    // AND gate
    assign and_output = z_a2 & z_b2;

    // XOR gate
    assign z = or_output ^ and_output;

endmodule
