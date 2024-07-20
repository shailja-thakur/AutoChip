module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input wire x,
    input wire y,
    output wire z
);
    assign z = (x & ~y) | (~x & ~y) | (x & y);
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire A1_out, A2_out;
    wire B1_out, B2_out;
    wire or_out, and_out;
    
    // First instances of A and B
    A inst1_A (.x(x), .y(y), .z(A1_out));
    B inst1_B (.x(x), .y(y), .z(B1_out));
    
    // Second instances of A and B
    A inst2_A (.x(x), .y(y), .z(A2_out));
    B inst2_B (.x(x), .y(y), .z(B2_out));
    
    // OR gate
    assign or_out = A1_out | B1_out;

    // AND gate
    assign and_out = A2_out & B2_out;

    // XOR gate
    assign z = or_out ^ and_out;
endmodule
