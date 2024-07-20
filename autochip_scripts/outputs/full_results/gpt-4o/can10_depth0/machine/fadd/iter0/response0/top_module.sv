module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Calculate the sum and carry-out bit
    assign sum = a ^ b ^ cin; // Sum is the XOR of the inputs and carry-in
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry-out is determined by the carry conditions

endmodule
