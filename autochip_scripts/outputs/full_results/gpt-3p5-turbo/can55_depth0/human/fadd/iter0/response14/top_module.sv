module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Create internal wires for the carry calculation
    wire w1, w2, w3;

    // Calculate the carry
    assign w1 = a & b;
    assign w2 = a & cin;
    assign w3 = b & cin;

    assign cout = w1 | w2 | w3; // Output the carry

    // Calculate the sum
    assign sum = (a ^ b) ^ cin; // Output the sum

endmodule
