module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;
    
    // Sum of a, b, and cin
    assign sum = a ^ b ^ cin;
    
    // Carry out
    assign w1 = a & b;
    assign w2 = a & cin;
    assign w3 = b & cin;
    assign cout = w1 | w2 | w3;

endmodule
