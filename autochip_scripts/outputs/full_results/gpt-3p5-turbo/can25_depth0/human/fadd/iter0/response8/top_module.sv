module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

wire w1, w2, w3;

// XOR gates
assign w1 = a ^ b;
assign w2 = w1 ^ cin;

// AND gates
assign w3 = a & b;

// Carry-out
assign cout = w1 & cin;

// Sum
assign sum = w2;

endmodule
