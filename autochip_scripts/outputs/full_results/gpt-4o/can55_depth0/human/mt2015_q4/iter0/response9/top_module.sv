module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B(
    input clk,
    input x,
    input y,
    output reg z
);
    always @(posedge clk) begin
        if (x == 0 && y == 0)
            z <= 1;
        else if (x == 1 && y == 0)
            z <= 0;
        else if (x == 0 && y == 1)
            z <= 0;
        else if (x == 1 && y == 1)
            z <= 1;
    end
endmodule
module top_module(
    input clk,
    input x,
    input y,
    output z
);
    wire z_A1, z_B1, z_A2, z_B2;
    wire or_output, and_output;

    // Instantiate the first A submodule
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );
    
    // Instantiate the first B submodule
    B B1 (
        .clk(clk),
        .x(x),
        .y(y),
        .z(z_B1)
    );

    // Instantiate the second A submodule
    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );
    
    // Instantiate the second B submodule
    B B2 (
        .clk(clk),
        .x(x),
        .y(y),
        .z(z_B2)
    );

    // Connect the outputs of the first A and B submodules to an OR gate
    assign or_output = z_A1 | z_B1;

    // Connect the outputs of the second A and B submodules to an AND gate
    assign and_output = z_A2 & z_B2;

    // Connect the outputs of the OR and AND gates to an XOR gate
    assign z = or_output ^ and_output;
endmodule
