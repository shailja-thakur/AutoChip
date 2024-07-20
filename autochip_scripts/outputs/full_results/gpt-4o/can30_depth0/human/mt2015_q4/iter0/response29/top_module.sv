module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output reg z
);
    always @(*) begin
        if (y == 0 && x == 0)
            z = 1;
        else if (y == 0 && x == 1)
            z = 0;
        else if (y == 1 && x == 0)
            z = 0;
        else if (y == 1 && x == 1)
            z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire A1_out;
    wire A2_out;
    wire B1_out;
    wire B2_out;

    // Instantiate first pair of A and B modules
    A A1 (.x(x), .y(y), .z(A1_out));
    B B1 (.x(x), .y(y), .z(B1_out));

    // Instantiate second pair of A and B modules
    A A2 (.x(x), .y(y), .z(A2_out));
    B B2 (.x(x), .y(y), .z(B2_out));

    // OR gate for the first pair's outputs
    wire or_out;
    assign or_out = A1_out | B1_out;

    // AND gate for the second pair's outputs
    wire and_out;
    assign and_out = A2_out & B2_out;

    // XOR gate for the final output
    assign z = or_out ^ and_out;
endmodule
